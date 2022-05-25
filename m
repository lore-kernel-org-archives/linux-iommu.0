Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF29C433EF
	for <iommu@archiver.kernel.org>; Wed, 25 May 2022 02:09:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27BE58416E;
	Wed, 25 May 2022 02:09:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7F9yAoSi6KU9; Wed, 25 May 2022 02:09:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D0A058414B;
	Wed, 25 May 2022 02:09:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B035BC0032;
	Wed, 25 May 2022 02:09:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43999C002D
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 02:09:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2741840488
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 02:09:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ozlabs-ru.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FLkwPwUkEIBi for <iommu@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:09:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 28B234032E
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 02:09:54 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id n10so18411922pjh.5
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 19:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=7HewgPeYrPk14Yu7XfczHo+WGbtndU4/U9oMWp3iEZQ=;
 b=jCRB1H238SE9kknCMH1tnhSn20Yfz6fSr1f3KJ4/8giQR5vLTkdbsszKjZkEgmj3DO
 dE0aTwD/orguWziTeOK9adLILEzjvM5qTbfN6r0WSNufZoW+7A1VLSjsmmKEMam2vm9h
 WySYeS3dIEvAGWzE92Ee/YC8+A5RFgPmMzg5ZB1FwnXHJOu4+yESW6COB57Zk/WhLzCf
 fL2l0afMZVyelZexUYBoaZ9vMGqhZwwSSquNIansb114vZn0xba0YE725bzSsyPI00tJ
 dpP7w2s9zO6uxL8gTuyWu/96QB17NuJGqxp+CwKU3EsSIBoWGYNByzh0hqFOW2J8AMA5
 ytrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=7HewgPeYrPk14Yu7XfczHo+WGbtndU4/U9oMWp3iEZQ=;
 b=wuvcptCCFwTmMFIFfWqgDCKI5L11VMkiXCKuVtbJB8vj8t3w2mTwxJqhoeppsG5FQh
 40g9FhUDAy4/UxNGG0FlotaCD/obSWIvhNTEJQU3HMIKaRdlEsEH7Lr7N7nlm4l/O9Oh
 X2ZxVVDjC5lty3d3bYdjduzRMml7L0oNXOs8c+qJo23leff9BGoy1nqPai0CTw1stwLf
 Auw3zR9qU/F5ROG6c+VEVzIeQcq6TjdNXhkyJHOHPaEmUmgfvj0VCyY7J/TsRiv9HzbZ
 Lc9EpznQgl6BDMwMqfBpd6lJZrftlzl89iVGUcontEaLfcOabIx+eULYIGTDTaXmMq7Q
 q4Sg==
X-Gm-Message-State: AOAM530niyLfK8OPSaDuJcofiDldhBRqj60zF0aAr288cO/UbozAx63T
 W03bm0LnzXY5qfhJqqCJcGe8KA==
X-Google-Smtp-Source: ABdhPJxJ/2I8pfFqpvWHy6IC95+fRwt2oq1iZC3uN6BehjVLlWXYEqS46Mev9lAqfZnrDLC4Kra0sg==
X-Received: by 2002:a17:90a:191a:b0:1dc:a3d3:f579 with SMTP id
 26-20020a17090a191a00b001dca3d3f579mr7860177pjg.30.1653444593610; 
 Tue, 24 May 2022 19:09:53 -0700 (PDT)
Received: from [10.61.2.177] (110-175-254-242.static.tpgi.com.au.
 [110.175.254.242]) by smtp.gmail.com with ESMTPSA id
 y13-20020a1709027c8d00b0015e8d4eb2cfsm7885640pll.281.2022.05.24.19.09.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 May 2022 19:09:53 -0700 (PDT)
Message-ID: <dde9738f-784f-ea7c-4318-a9260ee00683@ozlabs.ru>
Date: Wed, 25 May 2022 12:09:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:101.0) Gecko/20100101
 Thunderbird/101.0
Subject: Re: [PATCH RFC 11/12] iommufd: vfio container FD ioctl compatibility
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <11-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <20220323165125.5efd5976.alex.williamson@redhat.com>
 <20220324003342.GV11336@nvidia.com>
 <20220324160403.42131028.alex.williamson@redhat.com> <YmqqXHsCTxVb2/Oa@yekko>
 <67692fa1-6539-3ec5-dcfe-c52dfd1e46b8@ozlabs.ru>
 <20220524132553.GR1343366@nvidia.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <20220524132553.GR1343366@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux-foundation.org,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 5/24/22 23:25, Jason Gunthorpe wrote:
> On Mon, May 23, 2022 at 04:02:22PM +1000, Alexey Kardashevskiy wrote:
> 
>> Which means the guest RAM does not need to be all mapped in that base IOAS
>> suggested down this thread as that would mean all memory is pinned and
>> powervm won't be able to swap it out (yeah, it can do such thing now!). Not
>> sure if we really want to support this or stick to a simpler design.
> 
> Huh? How can it swap? Calling GUP is not optional. Either you call GUP
> at the start and there is no swap, or you call GUP for each vIOMMU
> hypercall.

Correct, not optional.


> Since everyone says PPC doesn't call GUP during the hypercall - how is
> it working?

It does not call GUP during hypercalls because all VM pages are GUPed in 
advance at a special memory preregistration step as we could not call 
GUP from a hypercall handler with MMU off (often the case with POWER8 
when this was developed in the first place). Things are better with 
POWER9 (bare metal can do all sorts of things pretty much) but the 
PowerVM interface with 2 windows is still there and this iommufd 
proposal is going to be ported on top of PowerVM at first.

I am just saying there is a model when not everything is mapped and this 
has its use. The PowerVM's swapping capability is something new and I do 
not really know how that works though.


-- 
Alexey
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

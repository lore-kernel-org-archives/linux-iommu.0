Return-Path: <SRS0=gcKa=FI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0A9C4361A
	for <iommu@archiver.kernel.org>; Fri,  4 Dec 2020 18:09:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA36922C7B
	for <iommu@archiver.kernel.org>; Fri,  4 Dec 2020 18:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA36922C7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9251687D70;
	Fri,  4 Dec 2020 18:09:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id szEJE-gKs8UI; Fri,  4 Dec 2020 18:09:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E2ADC87D69;
	Fri,  4 Dec 2020 18:09:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B19DAC0FA8;
	Fri,  4 Dec 2020 18:09:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88CBDC013B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Dec 2020 18:09:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 67CE8878DA
 for <iommu@lists.linux-foundation.org>; Fri,  4 Dec 2020 18:09:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C5EenqPaIOuq for <iommu@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 18:09:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 05A60834BE
 for <iommu@lists.linux-foundation.org>; Fri,  4 Dec 2020 18:09:46 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id x16so9974006ejj.7
 for <iommu@lists.linux-foundation.org>; Fri, 04 Dec 2020 10:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=WGJjavSrPVqb+TK1+7wxOVM38Oyh3+YMEGZxF1BbFxY=;
 b=OR9T9EvlAy/dd04tieJ4P4P7sxrRaGs5vyqVAop2GSalR+eMijdf4g5uH7NI+T/EYx
 IN7yoR5i61tyFpqb1grxBk30bJCixxluGHbaXLMA+RibdGWv8nmamTaEbVD7Vgkt0lRS
 0OFeQbu9Zc8wVEzLEwMVPMDEXBYdTM+OfNmrr1l4aWPC6JBhVwhtIjLFsY2KYIYuOJQE
 dKD0QUJa4EqkyBRx4QNmG5/Yz/RpTn0hL+4Eq6th7oXoJsKvqBv+d8ix4rhJvFhVfzw5
 hHhzSEe4lcFltTZ0iG7Zv7RiPKyNZ7iuk4zEr99vdNEg9OgumIMIQUWuoRFOEN0eh2TQ
 ITpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WGJjavSrPVqb+TK1+7wxOVM38Oyh3+YMEGZxF1BbFxY=;
 b=UKmJxUWHoNgd08v8bdoRK3sttszxecBKebTVNTbenIpW3/VAfQwkJW9eu78/0LYJIY
 Er8P5qJCrzxCJgLUXcfCRBx1x/nfYEWFgpgzTE2Lfk8YwsNKqiiW4Vu4Q3/d0cr+u+ZS
 t9miR9FCFBo9F1xCRDkUhsNZ3oGt1LUB0gLI6Kpmav+66FQhfNS+l0EKjFVQ8492l6EN
 xdKgKx3pnLprUMTitmYJJSZ9+yqhKlXWyKi5rdwsL9BYSQrfMcDroUXvoGUvdIBIFeb/
 CjViaXPpR2EGWCSp20wFtGJrHr3QLHkgIlGyDL6T3Zd2oAT3W3gK46OvlT1e2kkvrloq
 C6uQ==
X-Gm-Message-State: AOAM531G1UJJvaEieShZF4R0ABUCIJPpsYO6yu3iORuVKfrqEnSr3q3f
 /lwhBYm17SEmVCO0y7YAFU1yYA==
X-Google-Smtp-Source: ABdhPJzp+L/vpZbifDWJ9cIQRJaEl9MBlfuAuYBV+m+sCBd1z2CQwzBQVOhVqoOHo6Yj9Nyf1+ACoQ==
X-Received: by 2002:a17:906:60d2:: with SMTP id
 f18mr8007391ejk.528.1607105384457; 
 Fri, 04 Dec 2020 10:09:44 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id v8sm3802640edt.3.2020.12.04.10.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Dec 2020 10:09:43 -0800 (PST)
Date: Fri, 4 Dec 2020 19:09:24 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Al Stone <ahs3@redhat.com>
Subject: Re: [EXTERNAL] Re: Question regarding VIOT proposal
Message-ID: <20201204180924.GA1922896@myrica>
References: <MW2PR2101MB1130313B4AE39B7EAC09349B80EE0@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201105134503.GA950007@myrica>
 <MW2PR2101MB113096E822AD835F658808B480EE0@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201106135745.GB974750@myrica>
 <MW2PR2101MB11301F2185D1C9016310728E80F21@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201203230127.GD4343@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201203230127.GD4343@redhat.com>
Cc: "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Boeuf,
 Sebastien" <sebastien.boeuf@intel.com>,
 Alexander Grest <Alexander.Grest@microsoft.com>,
 Yinghan Yang <Yinghan.Yang@microsoft.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

On Thu, Dec 03, 2020 at 04:01:27PM -0700, Al Stone wrote:
> On 03 Dec 2020 22:21, Yinghan Yang wrote:
> > Hi Jean,
> > 
> > I'm sorry for the delayed response. I think the new "PCI range node" description makes sense. Could you please make this change in the proposal?
> > 
> > Other than that, the proposal looks good to go.

Thanks for the feedback, I made the change

> > 
> > Thanks,
> > Yinghan
> 
> Jean, were you going to update your existing doc first?  If you
> do that, then I can cut and paste the changes into the existing
> ASWG proposal.  Or do you need to send out an RFC to the mailing
> list first and finalize it there?

I updated the doc: https://jpbrucker.net/virtio-iommu/viot/viot-v9.pdf
You can incorporate it into the ASWG proposal.
Changes since v8:
* One typo (s/programing/programming/)
* Modified the PCI Range node to include a segment range.

I also updated the Linux and QEMU implementations on branch
virtio-iommu/devel in https://jpbrucker.net/git/linux/ and
https://jpbrucker.net/git/qemu/

Thanks again for helping with this

Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

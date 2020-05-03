Return-Path: <SRS0=M8Ie=6R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB184C28CBC
	for <iommu@archiver.kernel.org>; Sun,  3 May 2020 13:04:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A15382073E
	for <iommu@archiver.kernel.org>; Sun,  3 May 2020 13:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Dq4xmUY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A15382073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7ABB386E2B;
	Sun,  3 May 2020 13:04:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2zJipZkldjx1; Sun,  3 May 2020 13:04:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6D01786B31;
	Sun,  3 May 2020 13:04:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 501BFC088A;
	Sun,  3 May 2020 13:04:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A955C0175
 for <iommu@lists.linux-foundation.org>; Sun,  3 May 2020 13:04:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7C5C22042C
 for <iommu@lists.linux-foundation.org>; Sun,  3 May 2020 13:04:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f3RTFFxzmkWW for <iommu@lists.linux-foundation.org>;
 Sun,  3 May 2020 13:04:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com
 [209.85.219.68])
 by silver.osuosl.org (Postfix) with ESMTPS id EF893203BD
 for <iommu@lists.linux-foundation.org>; Sun,  3 May 2020 13:04:05 +0000 (UTC)
Received: by mail-qv1-f68.google.com with SMTP id y19so7031717qvv.4
 for <iommu@lists.linux-foundation.org>; Sun, 03 May 2020 06:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=lgDLstrxQHhDxzWYd9/HS8YbBd/gpsI1gpTdprUS3Jg=;
 b=Dq4xmUY0lO9O9aVqYMQW5AsSTJeAnnfNOWuxdYL/g2r28y6kJLGyYc1PX7+z0JukAq
 wyAcVZSwZkjc8VRCxLRJn26bGkxezGegSNuTNUn6w67H5qd3dkSA77rAL50b9yC404V4
 st+f6Z9L6/MaGb5U7JV0MHQEbLyEFw68ozLmhtw0LfDgKYWFJEl+/M0sjOi+SGMPNiuJ
 1PYT0sh2oERfJPQEuk2g3WZDGC2RoC37Z5PSNIZz7FSpBei+eYjhf2wy61mmLeqyF9AD
 ir673fIn5utfDxhEE2iD26R3vkKcGUE67v1Tjt05ErNGuWkt57eXT7Ah9rfKVFuIQ2A/
 96QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=lgDLstrxQHhDxzWYd9/HS8YbBd/gpsI1gpTdprUS3Jg=;
 b=db1oHAR8BI5RneCxsQyjVU/h/HHu6btxXvGPKSP3uCfrNK5IraHohDzAi84Q/6oHpi
 SJan6C5Z9iURSEv/UIbIBWkVsR0geZBVOkWr/ZCaAz3E8YW3zQlBk7H6d4w7VOx0QW21
 cH+H5bFqFJG+Q9q36zdUlXXOpAM74wRwZ5XJBBQXe9+WSxzl+wg74kfiT7YlEUMRIcDv
 yoSwzkDckLFXVUtzeBNJt7k7vLn1Ac3F+c+79mnPZ9YTt3pSjSSfZJguPxzIiCPd/INC
 n5gR67xYTd8kjh1nu//hcZaFDI4F3pfxfd+dnKH5wsYkVLzacr3SFOi1Ek+0831Nrifd
 0IeA==
X-Gm-Message-State: AGi0PuZIiOH4ZQ0lqAwqbaWiID+GUxUsVib0mlgso9BAtRTol4ZilJ6g
 0yk4JJ/IgxU2MwDpc6fkFdR1ni2HPpHbRw==
X-Google-Smtp-Source: APiQypLj7z+/+acBcByAY2J0cQ1YHYr/bMN4osB4axBDCIP2jxqqkeKhAAc+D3was7U+m5tQweO+wg==
X-Received: by 2002:a0c:e992:: with SMTP id z18mr12711287qvn.25.1588511044636; 
 Sun, 03 May 2020 06:04:04 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net.
 [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id i5sm7689441qtw.97.2020.05.03.06.04.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 May 2020 06:04:04 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [RFC PATCH] iommu/amd: fix a race in fetch_pte()
From: Qian Cai <cai@lca.pw>
In-Reply-To: <20200429112014.GN21900@8bytes.org>
Date: Sun, 3 May 2020 09:04:03 -0400
Message-Id: <E351FE35-3130-48B0-90ED-BC55469C73F7@lca.pw>
References: <20200418121022.GA6113@8bytes.org>
 <57CBF6B2-4745-4E36-9AA5-7E0876E3DA8F@lca.pw>
 <20200418183429.GH21900@8bytes.org>
 <7D03A3E2-647B-4FAD-886D-EE2764EC1EDB@lca.pw>
 <20200429112014.GN21900@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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



> On Apr 29, 2020, at 7:20 AM, Joerg Roedel <joro@8bytes.org> wrote:
> 
> On Mon, Apr 20, 2020 at 09:26:12AM -0400, Qian Cai wrote:
>> No dice. There could be some other races. For example,
> 
> Can you please test this branch:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git/log/?h=amd-iommu-fixes
> 
> It has the previous fix in it and a couple more to make sure the
> device-table is updated and flushed before increase_address_space()
> updates domain->pt_root.

I believe this closed the existing races as it had survived for many days. Great work!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

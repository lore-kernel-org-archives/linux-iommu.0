Return-Path: <SRS0=f5WA=E6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D30FC2D0E4
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 09:38:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BCB22073C
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 09:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="E6jhhwVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BCB22073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 138A584CE1;
	Tue, 24 Nov 2020 09:38:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BftA66g0Sg70; Tue, 24 Nov 2020 09:38:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 445DC84AB2;
	Tue, 24 Nov 2020 09:38:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26FDBC163C;
	Tue, 24 Nov 2020 09:38:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F5F3C0052
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 09:38:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5BDB9204D6
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 09:38:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NjmbUbKhN8Ey for <iommu@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 09:38:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by silver.osuosl.org (Postfix) with ESMTPS id 8C99D203F9
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 09:38:43 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0e360052021be21853ebf1.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0e:3600:5202:1be2:1853:ebf1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CE42E1EC0529;
 Tue, 24 Nov 2020 10:38:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1606210721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=mIxQeGPd5ay/UcAwPgNBuQ42UymVxYGQUjrVO6RwKWQ=;
 b=E6jhhwVoW/NqalShXB4DbazzDfcgmyJayc5KYXVkeB8CMqqMLHVxBSIrgilA2M0GYiHEnx
 WVDJpaWLhKXqdS8GYi2v8gYrAvW6YHGCa3G5texvNNLmu77ZCuHqarUkTAPB90Hiy1cQoI
 rY4yXG5THYW6gbbgiFs/MdYplMmcCj8=
Date: Tue, 24 Nov 2020 10:38:37 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <Ashish.Kalra@amd.com>
Subject: Re: [PATCH v6] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201124093837.GD4009@zn.tnic>
References: <20201119214205.11062-1-Ashish.Kalra@amd.com>
 <20201123170647.GE15044@zn.tnic>
 <20201123175632.GA21539@char.us.oracle.com>
 <20201123225631.GA16055@ashkalra_ubuntu_server>
 <20201124090431.GC4009@zn.tnic>
 <EF13C80C-42DC-4B51-8AF8-2C1D3859B490@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <EF13C80C-42DC-4B51-8AF8-2C1D3859B490@amd.com>
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Grimm,
 Jon" <Jon.Grimm@amd.com>, "Singh, Brijesh" <brijesh.singh@amd.com>,
 "dave.hansen@linux-intel.com" <dave.hansen@linux-intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "luto@kernel.org" <luto@kernel.org>,
 "hpa@zytor.com" <hpa@zytor.com>, "rientjes@google.com" <rientjes@google.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "hch@lst.de" <hch@lst.de>
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

On Tue, Nov 24, 2020 at 09:25:06AM +0000, Kalra, Ashish wrote:
> But what will be the criteria to figure out this percentage?
>
> As I mentioned earlier, this can be made as complicated as possible by
> adding all kind of heuristics but without any predictable performance
> gain.
>
> Or it can be kept simple by using a static percentage value.

Yes, static percentage number based on the guest memory. X% of the guest
memory is used for SWIOTLB.

Since you use sev_active(), it means the size computation is done in the
guest so that SWIOTLB size is per-guest. Yes?

If so, you can simply take, say, 5% of the guest memory's size and use
that for SWIOTLB buffers. Or 6 or X or whatever.

Makes sense?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

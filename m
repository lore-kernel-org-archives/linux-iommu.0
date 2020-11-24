Return-Path: <SRS0=f5WA=E6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD0EC56202
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 09:04:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C9D2075A
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 09:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="XI3UpvuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C9D2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BCBA986FB1;
	Tue, 24 Nov 2020 09:04:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uACqDNjSHMfy; Tue, 24 Nov 2020 09:04:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A539686F3A;
	Tue, 24 Nov 2020 09:04:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94E01C163C;
	Tue, 24 Nov 2020 09:04:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 067EAC0052
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 09:04:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F3F49204DC
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 09:04:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U-NUVgfTgTAe for <iommu@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 09:04:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by silver.osuosl.org (Postfix) with ESMTPS id 80107204D1
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 09:04:33 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0e3600a9cb1df0e98d070c.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0e:3600:a9cb:1df0:e98d:70c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C6C931EC0411;
 Tue, 24 Nov 2020 10:04:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1606208671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=6kMx6CvQEut1O2ATzEvOMdVThQx+i717xnGHX3Jg8qU=;
 b=XI3UpvuFRjCdrLWhgf7EC4LKLXAmctWaSMFnpzgoAUsi1xoMswvJ8RtUPwbcOUrprHIIgD
 35WAvbpYz/L50dZlnAX612/D34ep//wdmN4XdIi6pSsoHmEXlFt6ySwUKRWGY7ns88EGCn
 /UPxQZDHcjSGVgr0bgrr/v86OSDlFbM=
Date: Tue, 24 Nov 2020 10:04:31 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v6] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201124090431.GC4009@zn.tnic>
References: <20201119214205.11062-1-Ashish.Kalra@amd.com>
 <20201123170647.GE15044@zn.tnic>
 <20201123175632.GA21539@char.us.oracle.com>
 <20201123225631.GA16055@ashkalra_ubuntu_server>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201123225631.GA16055@ashkalra_ubuntu_server>
Cc: Thomas.Lendacky@amd.com, jon.grimm@amd.com, brijesh.singh@amd.com,
 dave.hansen@linux-intel.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, mingo@redhat.com, luto@kernel.org,
 hpa@zytor.com, rientjes@google.com, tglx@linutronix.de, hch@lst.de
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

On Mon, Nov 23, 2020 at 10:56:31PM +0000, Ashish Kalra wrote:
> As i mentioned earlier, the patch was initially based on using a % of
> guest memory,

Can you figure out how much the guest memory is and then allocate a
percentage?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

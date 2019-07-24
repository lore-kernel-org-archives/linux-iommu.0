Return-Path: <SRS0=WqUy=VV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899EEC76186
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 18:11:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AD4C217F4
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 18:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="zS/bVLGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD4C217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 292AA1311;
	Wed, 24 Jul 2019 18:11:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F15F6130D
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 18:11:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
	[209.85.208.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 17B15FE
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 18:11:46 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id d4so47940383edr.13
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 11:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=shutemov-name.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:content-transfer-encoding:in-reply-to
	:user-agent; bh=O8BpPykOGPMrcNWO68vuYRL0O4QY5mFmWnwLnMdbXek=;
	b=zS/bVLGPe7Biddu3tvwjxuJoE7XfssHm9A/D8B3sP1tRSW0ABm1Zr3GTP948ZUZoYk
	rRQk1qET++mJxWEizDZAZlrHpxRur3R4IwaejxU3NgmAAP0EBUVI+lb/54oEy/WdTZ9h
	SKobC8Q0AWyJr5Kk/XAxuCZLeTUzOg78ZegpDU6YlMXhQWYFdKRsi9QpqYTrCqUIgbEI
	vNQ4oIeVdvyPQLBmKqZdyuQkJeTgbO5xafzcXSyUD1eoBeiiEoSACykaToz9efeG/xQZ
	Opm842qAOGZH9V/l9cbqIRV8TfquUXfLQlDvLLZl8EPUa/YUvwrY6sdElsmQdqZvgcDS
	tdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=O8BpPykOGPMrcNWO68vuYRL0O4QY5mFmWnwLnMdbXek=;
	b=JuodJnY3F+vYlO+RNqbW35FM0Jjb7buWOQD1CkBiXbQt8fxUvKJiHz5YJmUpQ/cjVA
	fXE3FbvwrZ/ToeNk/AwcEg4KPgCwIwBkeL86hAflhw5YxJ4oifVXYTE1U0HpoMFdlPRt
	8fA04FocZOhxPIwbpXPB70xsaufAnHyEw/WV5WIZAMxSmzt5ueDweSUt8rcKROh3K3Mw
	wlm0NxJ/MRYBZiES6bJkBxpTKMJbAm0QuWuqyYzqCQKoafQighavp0WjEPRJZfftb7qF
	x4HIn0OvvxvES63Jm5HnDdioyY8L9glT75glcqTXNRIalGkHLR+s/UJ/lArdRs/7utLD
	/Ifw==
X-Gm-Message-State: APjAAAWj1leIiBKaY8CYLnB9nTCKFgMghXi6ls2Xw8fG+lEMj1LVxO8k
	QT07tE3z0Qa+ljb1Sn0SyGg=
X-Google-Smtp-Source: APXvYqwHZDCykwuaTSueWVYio2HcO73aA9TvoYdpNFeI/tjrkP+9Vh22NPhDR7Ipv0BvDyCS4iR4qQ==
X-Received: by 2002:a17:906:2f0f:: with SMTP id
	v15mr61261234eji.33.1563991904593; 
	Wed, 24 Jul 2019 11:11:44 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
	by smtp.gmail.com with ESMTPSA id
	o11sm9407138ejd.68.2019.07.24.11.11.43
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 24 Jul 2019 11:11:44 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
	id 00DBA10169F; Wed, 24 Jul 2019 21:11:39 +0300 (+03)
Date: Wed, 24 Jul 2019 21:11:39 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH] dma-direct: Force unencrypted DMA under SME for certain
	DMA masks
Message-ID: <20190724181139.yebja5yflzjgfxlx@box>
References: <10b83d9ff31bca88e94da2ff34e30619eb396078.1562785123.git.thomas.lendacky@amd.com>
	<20190724155530.hlingpcirjcf2ljg@box>
	<acee0a74-77fc-9c81-087b-ce55abf87bd4@amd.com>
	<a89e7574-096d-9105-45ff-34bbb74918a5@arm.com>
	<c4110c6b-686c-7e77-fedc-33782e5b3e50@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c4110c6b-686c-7e77-fedc-33782e5b3e50@amd.com>
User-Agent: NeoMutt/20180716
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Lianbo Jiang <lijiang@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Wed, Jul 24, 2019 at 05:34:26PM +0000, Lendacky, Thomas wrote:
> On 7/24/19 12:06 PM, Robin Murphy wrote:
> > On 24/07/2019 17:42, Lendacky, Thomas wrote:
> >> On 7/24/19 10:55 AM, Kirill A. Shutemov wrote:
> >>> On Wed, Jul 10, 2019 at 07:01:19PM +0000, Lendacky, Thomas wrote:
> >>>> @@ -351,6 +355,32 @@ bool sev_active(void)
> >>>> =A0 }
> >>>> =A0 EXPORT_SYMBOL(sev_active);
> >>>> =A0 +/* Override for DMA direct allocation check -
> >>>> ARCH_HAS_FORCE_DMA_UNENCRYPTED */
> >>>> +bool force_dma_unencrypted(struct device *dev)
> >>>> +{
> >>>> +=A0=A0=A0 /*
> >>>> +=A0=A0=A0=A0 * For SEV, all DMA must be to unencrypted addresses.
> >>>> +=A0=A0=A0=A0 */
> >>>> +=A0=A0=A0 if (sev_active())
> >>>> +=A0=A0=A0=A0=A0=A0=A0 return true;
> >>>> +
> >>>> +=A0=A0=A0 /*
> >>>> +=A0=A0=A0=A0 * For SME, all DMA must be to unencrypted addresses if=
 the
> >>>> +=A0=A0=A0=A0 * device does not support DMA to addresses that includ=
e the
> >>>> +=A0=A0=A0=A0 * encryption mask.
> >>>> +=A0=A0=A0=A0 */
> >>>> +=A0=A0=A0 if (sme_active()) {
> >>>> +=A0=A0=A0=A0=A0=A0=A0 u64 dma_enc_mask =3D DMA_BIT_MASK(__ffs64(sme=
_me_mask));
> >>>> +=A0=A0=A0=A0=A0=A0=A0 u64 dma_dev_mask =3D min_not_zero(dev->cohere=
nt_dma_mask,
> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 dev->bus_dma_mask);
> >>>> +
> >>>> +=A0=A0=A0=A0=A0=A0=A0 if (dma_dev_mask <=3D dma_enc_mask)
> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return true;
> >>>
> >>> Hm. What is wrong with the dev mask being equal to enc mask? IIUC, it
> >>> means that device mask is wide enough to cover encryption bit, doesn'=
t it?
> >>
> >> Not really...=A0 it's the way DMA_BIT_MASK works vs bit numbering. Let=
's say
> >> that sme_me_mask has bit 47 set. __ffs64 returns 47 and DMA_BIT_MASK(4=
7)
> >> will generate a mask without bit 47 set (0x7fffffffffff). So the check
> >> will catch anything that does not support at least 48-bit DMA.
> > =

> > Couldn't that be expressed as just:
> > =

> > =A0=A0=A0=A0if (sme_me_mask & dma_dev_mask =3D=3D sme_me_mask)
> =

> Actually !=3D, but yes, it could have been done like that, I just didn't
> think of it.

I'm looking into generalizing the check to cover MKTME.

Leaving	off the Kconfig changes and moving the check to other file, doest
the change below look reasonable to you. It's only build tested so far.

diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index fece30ca8b0c..6c86adcd02da 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -355,6 +355,8 @@ EXPORT_SYMBOL(sev_active);
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPT=
ED */
 bool force_dma_unencrypted(struct device *dev)
 {
+	u64 dma_enc_mask;
+
 	/*
 	 * For SEV, all DMA must be to unencrypted addresses.
 	 */
@@ -362,18 +364,20 @@ bool force_dma_unencrypted(struct device *dev)
 		return true;
 =

 	/*
-	 * For SME, all DMA must be to unencrypted addresses if the
-	 * device does not support DMA to addresses that include the
-	 * encryption mask.
+	 * For SME and MKTME, all DMA must be to unencrypted addresses if the
+	 * device does not support DMA to addresses that include the encryption
+	 * mask.
 	 */
-	if (sme_active()) {
-		u64 dma_enc_mask =3D DMA_BIT_MASK(__ffs64(sme_me_mask));
-		u64 dma_dev_mask =3D min_not_zero(dev->coherent_dma_mask,
-						dev->bus_dma_mask);
+	if (!sme_active() && !mktme_enabled())
+		return false;
 =

-		if (dma_dev_mask <=3D dma_enc_mask)
-			return true;
-	}
+	dma_enc_mask =3D sme_me_mask | mktme_keyid_mask();
+
+	if (dev->coherent_dma_mask && (dev->coherent_dma_mask & dma_enc_mask) !=
=3D dma_enc_mask)
+		return true;
+
+	if (dev->bus_dma_mask && (dev->bus_dma_mask & dma_enc_mask) !=3D dma_enc_=
mask)
+		return true;
 =

 	return false;
 }
-- =

 Kirill A. Shutemov
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

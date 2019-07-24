Return-Path: <SRS0=WqUy=VV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1278C7618B
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 16:09:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E1472173B
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 16:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="GJVHWb7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1472173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0838FC87;
	Wed, 24 Jul 2019 16:09:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5F7A0CA1
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 15:55:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 544BAFE
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 15:55:34 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id w20so47537611edd.2
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 08:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=shutemov-name.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=XRJqhDHx7Uz3bLvE/9qsXUPLXq2ZvJ6ES+tCrdeydl0=;
	b=GJVHWb7On5d8QH0JS1KBa6k/6lt7ksj0E0OwizyveGSnLr0z04TYjCyRU78n2/++jE
	R3CDZVBstiPt94TnRwdVhJhpDS2+6P+JJI1MTjsw1XyoZ5UUMw3QZFJKnR3NjFyLNInW
	TZGSW2o80wbRh0LqvfHdMTQRNl0JC55h+fHUPOr7LasgZlEdu5H1up4SX7/ty4M636jy
	C0ubX2i5+XcMhNoL5lYkF2Ek4gDcf3ST1E7rO7R6Qdi/r0q/KEXNGks3kwwcVo0R0m1g
	3f+PsI+XTG1YVUusS3hi/qo4L7Azz3HwENh2rBURg0P5iMOaTHQD7Qp0EIfRQls4xwDM
	2iLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=XRJqhDHx7Uz3bLvE/9qsXUPLXq2ZvJ6ES+tCrdeydl0=;
	b=bPMezLrIFdbqZzJzyQ2wgqdU6wHr+V7Hw2ctDxoQjojcdkbJdz/LzNbQDNNAFCAkG/
	eDvs6ire3JMVDaSBkTRXpjtvWJSztRfcoEmWpziUCD13dDt7xS5ckeErAXaTFl72ktjb
	sGeGFIsg3fJrjVVY3vqkGKR6RgFb8nwCwhv0uRXuytA1v5P+A17WXQCsVehBmfl9sfxS
	C+he4DqhlbKkjYf9wgVmwBcXtmTKrfUWjo6H+CvTUjdxTIgIYzVOMH4Kavp5EanQ42ez
	d7JwOlkQ+fB1aI8wbUgG3o6CmG+ESQqD7PjdTjGN0z8+L7xV9lCZO+6lFjHWn8wnpL8R
	v83A==
X-Gm-Message-State: APjAAAVfEIxci9TJAdwEy7ulXCNxDKZBOl4yLCnznrmH/lTHjA8aaMGI
	Pf5MElXHtbn8xttwQGYDhxY=
X-Google-Smtp-Source: APXvYqx9XAXP+lQcuBCtq0McEBVhakGbx6bv1s1MBRFOqKTBD7Y6h12RDBl4c4tj6bQaCkfELh3Qrg==
X-Received: by 2002:aa7:c313:: with SMTP id l19mr60539847edq.258.1563983732973;
	Wed, 24 Jul 2019 08:55:32 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
	by smtp.gmail.com with ESMTPSA id
	c48sm13305270edb.10.2019.07.24.08.55.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 24 Jul 2019 08:55:31 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
	id 8F26810169F; Wed, 24 Jul 2019 18:55:30 +0300 (+03)
Date: Wed, 24 Jul 2019 18:55:30 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH] dma-direct: Force unencrypted DMA under SME for certain
	DMA masks
Message-ID: <20190724155530.hlingpcirjcf2ljg@box>
References: <10b83d9ff31bca88e94da2ff34e30619eb396078.1562785123.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <10b83d9ff31bca88e94da2ff34e30619eb396078.1562785123.git.thomas.lendacky@amd.com>
User-Agent: NeoMutt/20180716
X-Mailman-Approved-At: Wed, 24 Jul 2019 16:09:00 +0000
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Wed, Jul 10, 2019 at 07:01:19PM +0000, Lendacky, Thomas wrote:
> @@ -351,6 +355,32 @@ bool sev_active(void)
>  }
>  EXPORT_SYMBOL(sev_active);
>  
> +/* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
> +bool force_dma_unencrypted(struct device *dev)
> +{
> +	/*
> +	 * For SEV, all DMA must be to unencrypted addresses.
> +	 */
> +	if (sev_active())
> +		return true;
> +
> +	/*
> +	 * For SME, all DMA must be to unencrypted addresses if the
> +	 * device does not support DMA to addresses that include the
> +	 * encryption mask.
> +	 */
> +	if (sme_active()) {
> +		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
> +		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
> +						dev->bus_dma_mask);
> +
> +		if (dma_dev_mask <= dma_enc_mask)
> +			return true;

Hm. What is wrong with the dev mask being equal to enc mask? IIUC, it
means that device mask is wide enough to cover encryption bit, doesn't it?

> +	}
> +
> +	return false;
> +}

-- 
 Kirill A. Shutemov
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

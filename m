Return-Path: <SRS0=vxCL=4F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BF9C34026
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 19:52:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 808782070B
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 19:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="esQZECPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808782070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 59A5D2042B;
	Mon, 17 Feb 2020 19:52:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ijtwz6flESQo; Mon, 17 Feb 2020 19:52:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7E16120104;
	Mon, 17 Feb 2020 19:52:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B6C3C089F;
	Mon, 17 Feb 2020 19:52:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32301C013E
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 19:52:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 20A4A854E5
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 19:52:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CIK-TH5P0lno for <iommu@lists.linux-foundation.org>;
 Mon, 17 Feb 2020 19:52:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 54FA781BDF
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 19:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581969121;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=0/9BSmLX4MRCy8kIrzvmMwpvIQmbMHKkCMt9qWFLNP4=;
 b=esQZECPuD+KSvSGKhse1Cpu1BQK3cgV9MOoJLIsP+lw3fqxqs+ZXXezRkkmNBdPMrzHUMQ
 JW1j9NztNMs2zIqC54ehRwSQfe0yDAceuqNnYVWb5KjfqjzXK31XjUqxn9sxaSdrVQ28AV
 7nsPcknaHDXb+xiNHlGtMWDghOMKrxE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-EfQjFKfhPM2uGzVxapUK7w-1; Mon, 17 Feb 2020 14:51:57 -0500
Received: by mail-qv1-f69.google.com with SMTP id u11so10881981qvo.8
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 11:51:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=0/9BSmLX4MRCy8kIrzvmMwpvIQmbMHKkCMt9qWFLNP4=;
 b=eugNV1Bt8DxFrWUb++DhP8GJiIvSU2NOFMTmgCjNBP9hSMu2NvUmz26xzoacHcwFRo
 9hkyNpIDlFGPLz0TQ9FZjMhQXj5tTSMG9uBZ8dBO+I04OKe7a7nPeu3b3YAT3BZVzfUU
 N6fN5wHcbzVSMKS5CI5I6YvaAxBZVDEs8pj4QoJXRgIb/w+YdznGLUIPsn+ygVg5rV7/
 nO92wT8dB2DEFPXoJh3pfDRc+XpjFd7Mohi/qd8B/nCPlGGaF45rjhs3biHxTNr+ZRMY
 YzYjCeaka4mCxD84Yoa0wgmMP7Sgly+s7sd+vbBShG6a6bWLe3qnc3AIc8fFDTgU2meT
 ZVHg==
X-Gm-Message-State: APjAAAXUKyWdk0bsIKDlOnviKan3f0EencdfJ+ZWiLDLCiHYCszyZf9k
 +U2opM57WpDM68Fp5N+QYLWDQqDG3eKhJvWoqOfi2kHlvhqunJFmvwkk2f4IFihlXzrBeiyODwE
 FFK6mAMgdqgyt2j1rD14M85UICtNGIg==
X-Received: by 2002:ac8:130c:: with SMTP id e12mr14535712qtj.233.1581969117013; 
 Mon, 17 Feb 2020 11:51:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqwmg2sQNzWisHtmSLVfDDkPHzKsic5owvJktuDRJGbM8YMd0Ljg16zsnFdj3keLyUWMcTSESg==
X-Received: by 2002:ac8:130c:: with SMTP id e12mr14535701qtj.233.1581969116833; 
 Mon, 17 Feb 2020 11:51:56 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id z11sm720869qkj.91.2020.02.17.11.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 11:51:56 -0800 (PST)
Date: Mon, 17 Feb 2020 12:51:54 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 4/5] iommu/vt-d: Remove deferred_attach_domain()
Message-ID: <20200217195154.5gkn5bzbkjg7x35h@cantor>
Mail-Followup-To: Joerg Roedel <joro@8bytes.org>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, jroedel@suse.de,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200217193858.26990-1-joro@8bytes.org>
 <20200217193858.26990-5-joro@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200217193858.26990-5-joro@8bytes.org>
X-MC-Unique: EfQjFKfhPM2uGzVxapUK7w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: iommu@lists.linux-foundation.org, jroedel@suse.de,
 David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon Feb 17 20, Joerg Roedel wrote:
>From: Joerg Roedel <jroedel@suse.de>
>
>The function is now only a wrapper around find_domain(). Remove the
>function and call find_domain() directly at the call-sites.
>
>Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

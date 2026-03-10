Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDF7399361
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773147252; cv=none; b=U7Zew62O19YpPFvkD1WibkJQyrEEPzWyddK2LI/pDk1aJCEtWQzoO15BPuoZVUM4Oc7f4RAtXm9UXNR7+pt4GY6uug4UTj70UNFRTmEsMnMmDuG5IrPRgJzuq/lHIQC8DTNJwtwbENnMqSI8GNpirTW0TRPKMajNZfnlT85x0F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773147252; c=relaxed/simple;
	bh=TgoJchP8+G/BTHDKgmEWupOwORUqE0/FZPIUEYu9Z9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asfQ/K/ent1JbF/QutyLNIJLFI1Rzhz775m9ZJZbgaWcVPtV8KOaNfkkp9tzFWvKDl2H2CKdD4hahAk/2CW1O7lQEmm7nReHUVaVegm9iOzV+N94L+PiOIDhG0fQ1+QY32opExhQvfxMP3PzHukA4h96JAP56dXmHCqWtojgLWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KXQoTynz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KXQoTynz"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aeab6ff148so1485ad.1
        for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 05:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773147248; x=1773752048; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mm6hm+LHoMGo5Ew01sq1dP9YSITnoqIDxYFDqmtgvh0=;
        b=KXQoTynzJbkjiUm+V2aKdtQekHCsQTLAk6TYwui2b0uXcoJxj6r318O9NEJ6YJe5NM
         gg5C+u3qjuCh50ssp+c6Rbssbpnsq3g9FohngmeMkJ2NyysvjxrZXYbP8tc+hM295sam
         YSqcAn3fYMLBwRZdFQjlmMtTlJTuZT0pOJYKyq7cUQ9x9SZ9P4vsnKQSN2Q7HdA34xgD
         G7Caukn+0TLArLbM+8VqlND6tfR+A0p8trto9KpxEebgbwF13J+agbT28ej1kt6J+rzI
         QsAEuVC7UNgKPEnMlLRkslC2GCue1mUAzAnoLfm0uFIrvWmmgqT+685zh6f0G7HhashM
         2ZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773147248; x=1773752048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mm6hm+LHoMGo5Ew01sq1dP9YSITnoqIDxYFDqmtgvh0=;
        b=hTozFl5pzKt0PcSnM1aJzcd2yHkpDl1D1pJayoz90Mg/SKhGUs4RkoQywelIasVcmN
         zGYFAqcVjFwx+nVeieCMeZDeUHnxsvci0mB6Br54RVNq0O6tQvISdo5d21UPqkrXWEU7
         1aP/uY7/jHIYvICowXaCDalc7CqUT8JxKxVOvMy+IGYR49/LwDj2x/YOVF210QWrskqv
         vsPMkUIcx9ybKrkL3jBnfOfxZ9MNMe0fTXdAClXdRoUkJ11cO8FVbieUXFgvD5MVGdXX
         c7JmXeFKXE5iABEHooWcYoocSroyyB1x3lUzwWnrmCmr8YQ4GfzZBeVzYkBq2fSPt+kq
         BU7w==
X-Forwarded-Encrypted: i=1; AJvYcCWHyc57AVAh/BMt4HLsy7PeA0n0BozwDLw4nEvzrT/qrLUajqdpkXg5uiIosTKqNoRFr0cd7g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5qJyblp/QLc6ApGXs9OtlcapeGaMH/eIhZ8NWqLQvR/Vtd5b8
	SpmQLb6AtDB8vNk8knctcjZVKLL4ITOfUwgWDlA78QsXbBoPm6S2upYUi4e07Hrp7Q==
X-Gm-Gg: ATEYQzwdsWxJIxceAAFFbZ8wkTL2XVNGXhEStTF/ZVGtzIy0DpxLFRWak/ZfGKHRA88
	sjyIiyFj9XVt0NhayuXSSLF0L2rJdlgouYNlnncVDL48q8K651IqAwAIKpg/Cufx+CPHuMwwRoQ
	xOzqyEcpd68EnzcOOJ2hXqTo0szMKc+BNp97jzfmxKzspeWaayjRNR9IMGTdCRM5FEfoPrIHT9p
	oAxZWEBVcbqCHv92y0r4Gi5vmOBqKPx+GReei2s4guFPKzZ52H3rlnvqw/shnr+BH+0iTqMrblm
	aDjIddAyFfF5zz/aQhQHqi6BtXRBbY6Bk9EqKAA2C4PWbovwz0ekrlOfbKqUm3VRMuOIyeS9rLU
	o/AgUEKDRE46iFZIH4eKZJvPSZyyk+NqpsIUMjPc1Amqn9Jo7ABVVR3jQnGU0eV44A1lkjQRnvr
	7cvknaVlVT9imWVL6N6slWPXUPKBkmIV3qliK9wGR8C70e79GT2693jhd31w==
X-Received: by 2002:a17:902:ebd2:b0:2ae:45bb:bc4e with SMTP id d9443c01a7336-2aea30ebe48mr3008685ad.24.1773147247400;
        Tue, 10 Mar 2026 05:54:07 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e0cb73dsm12445679a12.11.2026.03.10.05.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 05:54:06 -0700 (PDT)
Date: Tue, 10 Mar 2026 12:53:54 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH 46/61] vfio: Prefer IS_ERR_OR_NULL over manual NULL check
Message-ID: <abAUYvx6VEdSmInm@google.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-46-bd63b656022d@avm.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-46-bd63b656022d@avm.de>

On Tue, Mar 10, 2026 at 12:49:12PM +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.
> 
> To: Alex Williamson <alex@shazbot.org>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  drivers/vfio/vfio_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 742477546b15d4dbaf9ebcfb2e67627db71521e0..d71922dfde5885967398deddec3e9e04b05adfec 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -923,7 +923,7 @@ vfio_ioctl_device_feature_mig_device_state(struct vfio_device *device,
>  
>  	/* Handle the VFIO_DEVICE_FEATURE_SET */
>  	filp = device->mig_ops->migration_set_state(device, mig.device_state);
> -	if (IS_ERR(filp) || !filp)
> +	if (IS_ERR_OR_NULL(filp))
>  		goto out_copy;
>  
>  	return vfio_ioct_mig_return_fd(filp, arg, &mig);
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

The cleanup alone looks fine, but I'm not sure if the maintainers would
be happy about the tree-wide spam, since each patch might go through a
different tree. I'd wait for Alex's preference/ack on that.

Thanks,
Praan

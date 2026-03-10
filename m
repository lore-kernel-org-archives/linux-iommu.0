Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8403AEF47
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773168054; cv=none; b=SKFqS6now4orMgaZX73anUpwR063z/DYgU5oO+Pz4CDPJg3ocC+zQNAM43Nbb5xkzSSBtHgg7LL4XW1hZ1k60a/xPN2ckPxWzENGA6ANuqVR6+cI/rZnQ3Cj4/9qMfQ5CkvEM5RfEgoaAXUrej/8cXSqndyl8h9TmpVKYVW6IPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773168054; c=relaxed/simple;
	bh=67BO0RZg8rxb/E50RmGcBJlsPR5Ae9xmCy+Q7v8QtDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5YkjUUJBV1v9w6glWVAc19NSmabp+/ufD6M3HIg7xIQ9tPUgJy5EgsyEzePD9HAxwSAXlI3eLb5TtexFnzIjf2AJs2lzJaIT0uPKg/uCAG2KZDFXWryFngDUs8lQ09bBAFlW5M5qn2MOoXMuWCBdUu35regdlVW0rkKDJfSb04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7G+/4qr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7G+/4qr"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae82df847bso30023655ad.2
        for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 11:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773168050; x=1773772850; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bjFZ9oZWWc3RZ4UdO5rq+AZbr7uPDX73K58gh1+yuH0=;
        b=l7G+/4qr5ViVAhZarVR7sYpVC7nNDWFrgTmkDh+IglL4EDFBXK5kmtbOmHOOE+m7ZA
         oKRsbZuBJJAcyKXm0p11yiTyLVNTT3VS6ZYXQOnexXwVrdImouiIT6OxswPKVswgV5TT
         cZK8/R9LzrIGilaVm9CRyDF9trvvbdsbxVwvj+BxRbswXmqkMFvaykVZWCkLmkxY1Uut
         EyaAfbgOPiY9V9eQcoQgNBtyOL2YIDI52loZZxfirEb6793tjh4ysr+VcQ0DGCw/0aL8
         eaymqqt667p5TCNw5hKBc1bqNC8HMwCk6SSFkfjVmoLNSGP1YKoKT23V20lcfhx27Q0I
         JatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773168050; x=1773772850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjFZ9oZWWc3RZ4UdO5rq+AZbr7uPDX73K58gh1+yuH0=;
        b=xTog4qtQfdaWhzjFGQHE6oPb7NmePn6p4n6gB5lyGuW4zb8oiYTngAZw9XCz/rRfrs
         tJfBeTNPzziehFkYagsYKhhDUp3r3EAc3hD3CW2+bxWqaUWoX7EB9enj37kSaiTAONuw
         gpzi2HfQCS+lAfzdn9biJI8bFtK6+/AxdePSN3LaF3U6/ub/tFEgZlw5EqXuqK2FLlLj
         kWoxzjGP85kb+55t//vqrZcESNh88XPqq5b7GCsIXEGxli3GdsHw57Eh+gWHPnDFUTkA
         z1SgSVm4KLsyS3Oxym7MLKmgVLxNv8wg2usUASX7vwIYO0+r6BUXZVXV2pQ25ChZbhvx
         v+bQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/ykfhrNW2NTE+hSazYfiM7mt6H/40WwEC4UUzPwareraptdSaDvGAscItMEqDDBSpXB/fjQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPHPwQGsjk5BEbFpskohqIFWsOGDSYqC2HqVK989TucPZ4ibIG
	ph8hqxbSnAU6N+GfoBjEvC7XosjOVAFCIdyUAQjWwyjCW2qCt+Xh6lSx
X-Gm-Gg: ATEYQzy7t2W63gHXYI4lKllyrc7w6jz5rqS2osdpgoFQUfEGQTRII3WD3FsUzofZZs1
	rhDm3UNCPLEwTmk9QaEhRuhzVpDobLuxXBmDhaJwKcFUE1wVtqSgJ1gz5aa3Z/bef/vzLlhpfd/
	nwLMVaeLTk+OPe1eitZOi9SzZDRy1oro2WNn+R3kSgADF3GclSPNyZB075P4FUdXYAIbnnFsbNf
	FkPXXVfYo1RnK0Selr75qKqXNcBdeM+SD55f2hIrCipCek0k2/e5icmieTLG7x20wrX3HEj+WGH
	/MNbVkyWczAG6thNEHQvWrgOu67XUTgSODYiWvJEWpmitKSIgZNi+Ak7azTTV6n6DcbxUfpULQI
	nHjcgIW3MfzYZ4Q+SAvtSbvOT2nUOELjE8Sgo5YTEzDR9QINi+pa7knS0sBfyoFEcUUKi4NIO/t
	8MQdDD8IYN+YIVF+w/43udr+pcMFlfxP97L2BpV1SIlfaPpw==
X-Received: by 2002:a17:903:28c8:b0:2ae:5671:7071 with SMTP id d9443c01a7336-2ae8252cf0fmr96662285ad.43.1773168050081;
        Tue, 10 Mar 2026 11:40:50 -0700 (PDT)
Received: from google.com ([2402:7500:a44:85b:2953:97d3:b283:95c3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e58592sm220535625ad.14.2026.03.10.11.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 11:40:49 -0700 (PDT)
Date: Wed, 11 Mar 2026 02:40:36 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
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
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev
Subject: Re: [PATCH 00/61] treewide: Use IS_ERR_OR_NULL over manual NULL
 check - refactor
Message-ID: <abBlpGKO842B3yl9@google.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>

Hi Philipp,

On Tue, Mar 10, 2026 at 12:48:26PM +0100, Philipp Hahn wrote:
> While doing some static code analysis I stumbled over a common pattern,
> where IS_ERR() is combined with a NULL check. For that there is
> IS_ERR_OR_NULL().
> 
> I've written a Coccinelle patch to find and patch those instances.
> The patches follow grouped by subsystem.
> 
> Patches 55-58 may be dropped as they have a (minor?) semantic change:
> They use WARN_ON() or WARN_ON_ONCE(), but only in the IS_ERR() path, not
> for the NULL check. Iff it is okay to print the warning also for NULL,
> then the patches can be applied.
> 
> While generating the patch set `checkpatch` complained about mixing
> [un]likely() with IS_ERR_OR_NULL(), which already uses likely()
> internally. I found and fixed several locations, where that combination
> has been used.

Thanks for the patchset. However, I think we need a explanation for why
switching to IS_ERR_OR_NULL() is an improvement over the existing code.

IMHO, the necessity of IS_ERR_OR_NULL() often highlights a confusing or
flawed API design. It usually implies that the caller is unsure whether
a failure results in an error pointer or a NULL pointer. Rather than
doing a treewide conversion of this pattern, I believe it would be much
more meaningful to review these instances case-by-case and fix the
underlying APIs or caller logic instead.

Additionally, a treewide refactoring like this has the practical
drawback of creating unnecessary merge conflicts when backporting to
stable trees.

Regards,
Kuan-Wei

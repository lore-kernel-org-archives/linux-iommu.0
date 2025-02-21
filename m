Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7518F6E
	for <iommu@lists.linux.dev>; Fri, 21 Feb 2025 07:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740122186; cv=none; b=LM8dGE/sDspbI7BhI65k1St3AkxxvrX4CvoibOZO0XzZE2Y7xd9GKqNb4wkfLcYBImTUplBrwU8F75OLrLR6ZbbQnkuYRc/sq2Ce8hV53qmyuY/YtqLKRyafULU2k+7XK5qM3nau+3UWZ4x8BOXashBJzxnqwZXSFYldIkbZvmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740122186; c=relaxed/simple;
	bh=tWGBRdsxJMsGRu8GYB5sHoxZI2HOaN6giry8hC8I05Q=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:Content-Disposition; b=Oe4eMZakNK8PpFR+cwM3pxanavAuaio5j5sa7azroBkXv6wgeJfKRiZ9UcjJMKUBHJKyr8inVi9v1lSnJdqfvZaVNrPZ8M0dR1+BMGXozNr3WqTb+R3+6yD84Du0iZVW3dx9Tgim8wrHvh7LCDEZUrDn9VH39c5qhoYxVI9CFy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bQHHm3St; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQHHm3St"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740122182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=tWGBRdsxJMsGRu8GYB5sHoxZI2HOaN6giry8hC8I05Q=;
	b=bQHHm3StOMyx18MrlAEusEvvrt4ACsAh4cnwCcuhB70aL1KmK8m9N+fwZJYmpNVEQYOmD1
	lFkgSgp5XRpnNbUz3FBGRAH1OT2X/Du8ieeaFR7X1xvSqWKH2oL0bp6CgLMvhSuvwuQITl
	pC3VWl18fyoz4g05+W696DJ4CH7lURk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-LrqIBE61Od-3Di4uqHp__g-1; Fri, 21 Feb 2025 02:16:21 -0500
X-MC-Unique: LrqIBE61Od-3Di4uqHp__g-1
X-Mimecast-MFC-AGG-ID: LrqIBE61Od-3Di4uqHp__g_1740122181
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6dadae92652so36815876d6.2
        for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 23:16:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740122181; x=1740726981;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWGBRdsxJMsGRu8GYB5sHoxZI2HOaN6giry8hC8I05Q=;
        b=Rd4LjyWTCt02qbA61TFgn5fKekj1nBLogSy5yJGWA7eWWqr+zLPKmvcjMhfyMtiRsc
         OoBJ5hmdHhAXVsk7ewGe6OR0S/cDSaRZwnfZtSm6IpEC7JAL/UxaKcjLk3QPXh/rVX6t
         S0pl5Cpq/Xv9OygqudQ6cv5D7yssbwr85R0eSLIdTzjYA/lD6SGg2Kkub7pJHUrbhmt3
         4yQapxEMWlV0gPlKX93dPHLMxwIY2QQmjmjMdvn575FAPiNgKgbN4flBwJwRX0/GrDNw
         BV5y8YeKWPFRVLwfplQEhqNnid8ORS4PjhZPRPP7EQSImYRsAc4ZpSJVtnuYfgcz4Nt6
         mu8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrOtSV/XF83qG1jkdKtGv+evhqc2m/UvH7G56vfs82o6tS9Vx4exa3gyqQaXCEoYxA3RwNDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfWbB/B/NR93I8NcmkKrGVeeiXjCLrNiqjlJ7RqC2gEPzwkk2Z
	aVZs7CWJVZqn2AqvOTxTPS7tgltXfgii178Frx1cljqC/yfBpHQw8/YbrlbzNtUODMkzOuYPZIx
	Q7ageXujBgdWobcZAbPAVe3Po8jUbQS1wHdCXCsw/ByRVifUqv5B7/z4zCTL7
X-Gm-Gg: ASbGnctmdPR4fwbUkMemdGZzg/bTR3G5WF6fp0+nTNM3g21I/mV8il1kThwIGF8aQO/
	Znac34q66xjERdCAiITAKyxlbC9wCLxBKiSEQLkeXmicLIIqujYzPwIQTwq5Q4KLIDPP7cqeQ3o
	ceD5Z5di9iZrj4w5cinkapxVzuBEORtIgkEZ5CpyhNtkGbqShapLPbrBBaLuf1LgBWFE9k27Es6
	xgK7/+KM9pbjvBfKs794ireEIgqs0DsN2u/s5dw+0xAtbUX9ndcq009DnoSVD2k/9TlsytuxNyd
	jKN3Vq54gK24QKkWP8KPzORzI1+2tCpyoCDzCTCpDUQu
X-Received: by 2002:a05:6214:258e:b0:6e4:42c2:dd91 with SMTP id 6a1803df08f44-6e6ae99f25fmr31496776d6.37.1740122180953;
        Thu, 20 Feb 2025 23:16:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENfiejO/ZZMS4Lr8Pgc0ZAWFpmym8NxoBNtS922xSyt1DOxXmRpwVRDY7dJ/5kJ3EcwKedqg==
X-Received: by 2002:a05:6214:258e:b0:6e4:42c2:dd91 with SMTP id 6a1803df08f44-6e6ae99f25fmr31496596d6.37.1740122180651;
        Thu, 20 Feb 2025 23:16:20 -0800 (PST)
Received: from localhost (ip70-163-223-251.ph.ph.cox.net. [70.163.223.251])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d78640fsm94480096d6.48.2025.02.20.23.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 23:16:20 -0800 (PST)
Date: Fri, 21 Feb 2025 00:16:18 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: baolu.lu@intel.com, Joerg Roedel <joro@8bytes.org>, 
	iommu@lists.linux.dev
Subject: Question on context setup for passthrough
Message-ID: <rz4kc2zxi4fritsbmjsa3ekqncguvnmeir5se3fhu7pzhtgipk@2u6ps3q3gsqz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240902022724.67059-7-baolu.lu@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vpn6kwZLryYQehOurdec0iR2V_KiA57geh1J2Fm9jO4_1740122181
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Baolu,

In context_setup_pass_through_cb there is a check that bails out
if dev != &pdev->dev which doesn't exist in the code that sets up the
context entries in the dma domain case. Is there a reason this check is
done in the passthrough case?

I've been looking at an issue where a vm is running with an
intel-iommu device, and has a pcie-to-pci bridge with a device behind
it. When running with this commit, and defaulting to passthrough it
gets a DMAR fault for the present bit not being set in the context
entry when the device is coming up, and the rid for the fault is the
rid the bridge will use for transactions coming from the secondary bus.
Without that check the context entry gets set up for that rid, and
it doesn't get the DMAR fault.

Regards,
Jerry


Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11CA33CEA7
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496799; cv=none; b=Snwo07bp7ziDdBLjPwtzEUJseE+IhGpanAVNDIUj7Anx7vl9//1OdxKIcMDF37XhvCuMmbOH6C8oIu3Z8TNyJDpqfUsmEBOIlll0cPSx3yTKTYYzrfDoMj2EEJoaFGfJGJKXVcOuyN11Kh4A5QWFi+m1oLPBRblu/r1LlxKAOZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496799; c=relaxed/simple;
	bh=W2KgLfIMUq9nYm3lPVNNRuC+rhvj0c5Ysm7uBo7Ldm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eu/0peIi5B7Pgonehgg/itLdNPPSV28KHYEoY4KDiRfp11hiF7wAwNQTrApb1u4CUCOKDNWc8uec461i9Tk7JcaTwa+Ly4vqiqbNfqDLDYMG8Gsy7bqPBQrcyGaWi3CDRlzl82NiseI66prExVkRhL8tkX8OnWOloAZC582tq6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JoVq/ysG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JoVq/ysG"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf2d865383so72435ad.1
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 07:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780496797; x=1781101597; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSsx/HNJMSWT4+DTHx2JEcyU4YhDU3KCMcSKr9Fho38=;
        b=JoVq/ysGUnpgHPqc5LxnagmBozADDAh9ElNgAN4rYQUMeuQuMYa3L2T1RBrzOXlbzz
         v/MgG2n7fTyRDBhq49T4DN2bkclLDExmlUVuoUVI8jeCI+DoLVlFc5DNZKJO0eoYsaNX
         Czl986bkmub7xpbLth4nSVYqo/3g+bPfw9djg7pGHZfkZURKnNRSyR3by0JoVUDLiveO
         z86piTjbw+B3HiMkfBjEpiZv+5vDMhLGjeDHGmSlLTskXxeSPRl3+QwJkyzXoepjyvB1
         rIyb6hQR/QKiVw7acoBymtbZIEzaM6irvmS2T75ywOCFo/teGQuGHpDmtKVyCa6z/UH4
         QF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780496797; x=1781101597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSsx/HNJMSWT4+DTHx2JEcyU4YhDU3KCMcSKr9Fho38=;
        b=AjU9mubGluHAujP3SWoSYjATjytQxNiY2qBROpZQT12uuIPGjbxcR0BYQb6+nUH/uI
         uPhnMI83mSofuwq+fVp+opdf4T5F20QLuppGiePn5P/LddgbhDlxkOCQMhlWjOIIkILC
         KtHVG2hBTR/viTJrazn8eWwsLXZPQCezX3FMIftk+78NHFAirHczyL7TEWrrdkWHMm5G
         1IR/yRcOuH3idK2C6+/VRytK2jWv5t16w3fn5ccltsu35VOzGrSI0ROMx5L98cR8xbmv
         PNTZtmZVljlVZxAR/yFYxtlK9m9i6WDdgIfXnY+zvBcs16wSYLu/BOp/tN4+6BMvcnxZ
         n3rw==
X-Forwarded-Encrypted: i=1; AFNElJ/SCPUI5+7xRc6dHQadJYwDjEGOAHheXD12cAMJxfR8U/vOLZ6i+bpecaVBIy1LOUZt6R+fmA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBEWRSGCc3HrdrjQkB9tQc/Yls+yh47LD+rz7jPuNIMytNOGKf
	Ymf7F3V56nQJJutKi9eTku0PtnZvXGTHwW4vMmR0cFfEDuJMLkZhZK7O/FhFjYBcAA==
X-Gm-Gg: Acq92OHheVk7xUYmqE5HEwFSSTlYI1Pge5+F5/AJ4o9dLQgkuYEJ0ONGuKe754tQNGN
	P/9xmymQtAP9LS5Gp+Ctk5Anx2wtrbrXUCJ3huu7NV5UsEs0ycCE6nGS8jMKyjdfEWvQbRFRZPQ
	WLK3LwPrz1qR1Iy2RxPNmt33a6cfauPkNU9NOXVyZsL6V9U1XQNoF+Yc+4WaaY5lb7y4rUpCSlZ
	wzer6m8EhWH7BgO7r8UqS9rvzbrJgLaNXxg9vWEmwzzx0SxZyEBY2PMK1Hj8rtPZn64TTFWSwl8
	jB4dgvtZ4tfArtXWkccCr1PSLUjMdCeSs8D53lLPhe4Y7aboEoX8NTczYRZL+NlRYD2XetwYJBn
	3+LQAxEWXYuoJz52Tpx0+XRL4HMysfbvR/qDDwAgxnHSBVGOSVXD0KVp14NP2+MyGPt37VfJWzF
	CviiHXhBTC/WQmPutUcAwagYFeaNlaOqjRMq5mxJ4exi0mRy7cMxLm5jtDzndu3BXpsm4tCCU=
X-Received: by 2002:a17:902:f712:b0:2bd:63cb:c5be with SMTP id d9443c01a7336-2c16fa7339amr1648965ad.5.1780496796592;
        Wed, 03 Jun 2026 07:26:36 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d240sm29068465ad.58.2026.06.03.07.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:26:35 -0700 (PDT)
Date: Wed, 3 Jun 2026 14:26:30 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, joro@8bytes.org,
	baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 6/7] iommufd: Avoid partial fault group delivery in
 iommufd_fault_fops_read()
Message-ID: <aiA5lmader-zPqEd@google.com>
References: <cover.1780343944.git.nicolinc@nvidia.com>
 <360cab4d4aeccb0bae275a970e2b3c340a71e0e0.1780343944.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <360cab4d4aeccb0bae275a970e2b3c340a71e0e0.1780343944.git.nicolinc@nvidia.com>

On Mon, Jun 01, 2026 at 01:42:37PM -0700, Nicolin Chen wrote:
> The cookie returned by xa_alloc() in iommufd_fault_fops_read() is per fault
> group, but the inner copy_to_user() runs per fault inside the group. If a
> copy fails mid-group, xa_erase clears the cookie and the group is restored
> to the deliver list, yet done is not rolled back. The function returns the
> partial byte count, with the successfully copied faults sitting at offsets
> below done carrying the now-erased cookie. The next read() then re-fetches
> the group, allocates a fresh cookie, and re-delivers every fault including
> the ones already copied; userspace sees duplicates carrying the new cookie,
> and a stale cookie that can never be responded to.
> 
> Use a local group_done variable that tracks the per-group progress inside
> the inner loop, and only commit done = group_done after the inner loop has
> finished successfully. On a copy_to_user failure the outer break skips the
> commit, so done remains at its prior start-of-group baseline; the partial
> bytes already written past done are undefined to userspace per the read(2)
> contract, and the next read re-delivers the whole group atomically.
> 
> Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

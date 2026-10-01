Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B37027AC57
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 00:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790816174; cv=none; b=gmqrNc99iA7K6A1BT/kth5NQP4rcTFLnKAeyWRYn/PkRFV0EH04OhbZ15e+iBqCt//M+PSGZGYzBbuKhaNtWRmFRTFBP1y4ozjgVXumGWa6b+nrK10gTBn+/X3LnkNMCeAqMAC8eAMkyGhNp95MhpNdTkTVRZ0VJTyZ1oNaXwfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790816174; c=relaxed/simple;
	bh=U56QULVWqsKJW2EZBRefVWv3E+jcCLq19wO8Z6fvjlQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:In-Reply-To:
	 From:Content-Type; b=CBrljxN7z8pieQ1y+dufLnk9rruZR6/1ndiRUjN27HZLthK0LwWvYl7AcULiJjPSSlR3tg2DgZlUGKB4OmkmFlqi2V0sD+ko+cxGCyzW4vFfeYeJ34Mvwj0FeV4hTvQ9C1tNm34l83qab3nvlvNLhJk3IDMEp4KItPK/20AnTdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/Hc0Kjs; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/Hc0Kjs"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e83a388f8so43783625e9.1
        for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 17:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790816171; x=1791420971; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:from:in-reply-to
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7SWQolDlxs/mWv18+ONCdedDA47CMCmGgXEL49Xti+c=;
        b=k/Hc0KjsDYjvF6dmmipUwPVn2qHi8rlgTmQisqFUlTrTDl9dOxBpsOe9WT6B6lfDG/
         G5kMuwmSl8gWyAh9jc2D4m38xNhwQw9i3d2itXfppfz8pbyTQ3GY0066PARuP3PI+XXo
         pqxU8LzSuflXuMNSlB24QikC2hNkGZzRdke2PwW3cEtnI1bsz1LNwc0898jy2XaQwRY7
         5drgHekpDWeaj0/0vfY9DrpJYfBp94tmnC0RakOK7EeSECtKtDvVTt4k707p+Yl+OnDJ
         ufQJxS6ZBZpRTszA3lEGOaQYBRiFVJJINs2gavV8yeIk3+8l5nI3BBuQsaXydvWNjCSU
         Dsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790816171; x=1791420971;
        h=content-transfer-encoding:content-type:from:in-reply-to
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7SWQolDlxs/mWv18+ONCdedDA47CMCmGgXEL49Xti+c=;
        b=teOJ0muGhwEagsP18cy9P07aLgzOMxFIfvy8AgWz5GymUD+9eToSZR7mKAhnlX8AAS
         xHs8g+oWCbWe7Lc5RBr9Tiw9Rkxtteo9T8SCKPcBYa/Ien0Q14/BgrSO/y6/B3HvNw0t
         0k5nfAPaWE8/ENc7JAssmO0Yu2EP8/U+Dv/5acdf2CqU7oWpEuMk9fW/fOaUlnFpg1X7
         BfPWnaJxxfmqyxLzn3ChJi4z3w8ThDUIHSgE1yG7q5g4Yqhm99k+x0M5U/KUc0Lws12n
         Bzo5jSXJhCXC8BcHjN+AqpFtlQUqTUWOExZ0dkRMwgGPWCkhHI41g581+HdN3V9uB35l
         2kGw==
X-Forwarded-Encrypted: i=1; AKwUvBx6Bs6nyZMk5aumEDschmJ2XT4nKP95AP7wcRq0f+f2NcAvokx6ZjwKmsxriSQJgGUX0kMhKQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nwmlLMEJX9qRLyKW9D32lzfL/9WRHdgHoDJIueCgQy90v6L5P5
	0ToDXs+LBlv39ARlJKep+VR5RFGc1w2QkFDL1jMWvIoT52qf4eKeWsvc
X-Gm-Gg: AYBFou0+zdTFRQ6EcEQ1ngERNMAxK8JJdbynIrTqsmUbET5An0v9d9Rew7pq1VN6QzN
	33Vk3v0FyEqBTlMaZTptrutPEfPgRhcm7K2ouZZqebiWOQjzE4wLcDIbC66agdHuWIb+0TrO+hb
	UrgIZilS7sAGFivTX1IXJCmAswHCgfc3QAc5WfIKx6wOewjw+S4uyasAlKlJ4TzvOb858oKT6Le
	K+1ioDr1dTJMvvzz//h+RH1vPJ8jrBB/R1jdNzej7TttPuM5vkCSKWevHRWASNY3Jv1glmpNItu
	VDWk76e1UWhuPdQZoIno4I3ROjKSe6SnIze/ul/9T6MzW2LcEZKn3AT78x33fG4eiJDqqn50gJp
	iJZC4zildAIcxWE4rvKqBCSwCKhlXHNGPojjYPhYU0zufMk0M2iRnM+vkDBnfmd+LphFYLOiKkr
	NSyrfK12BHn+NP6lIrW6hiWFiOasEiEvwq8BUbyGcifLRH+qwtBsY9uOTmAeOhUnFivlJT1Nsrp
	KlqGYInvZgtUb9Po1PgmD7IzQuB9pXvl++Y
X-Received: by 2002:a05:600d:82f0:b0:4a0:1e64:4238 with SMTP id 5b1f17b1804b1-4a01e644325mr29628645e9.24.1790816171286;
        Wed, 30 Sep 2026 17:56:11 -0700 (PDT)
Received: from [192.168.1.6] ([90.243.208.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f949709sm36071075e9.12.2026.09.30.17.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 17:56:10 -0700 (PDT)
Message-ID: <3d2d6a70-8a00-4ef4-89ac-8000d9f9bf85@gmail.com>
Date: Thu, 1 Oct 2026 01:56:09 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: suravee.suthikulpanit@amd.com
Cc: frank.gorishek@amd.com, iommu@lists.linux.dev, jon.grimm@amd.com,
 joro@8bytes.org, linux-kernel@vger.kernel.org, santosh.shukla@amd.com,
 thomas.lendacky@amd.com, vasant.hegde@amd.com, alex@shazbot.org
References: <20260424092213.16976-1-suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v2 0/4] iommu/amd: IVMD handling cleanup and ivmd= boot
 override
Content-Language: en-US
In-Reply-To: <20260424092213.16976-1-suravee.suthikulpanit@amd.com>
From: Adam Pelka <adampelka26@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Suravee,

This series removes the IOMMU_RESV_DIRECT regions that block VFIO
passthrough on my Gigabyte B850 AORUS ELITE WIFI7 (BIOS F11, 05/21/2026;
same problem on F7), Ryzen 9 9950X3D, RTX 5080.

The IVRS table on this board has three IVMD type 0x22 entries, all with
flags 0x08 (exclusion range only, no unity/IR/IW bits), each covering
devid 0000:00:00.0 - 0000:0f:1f.7:

   IVMD 0x22 flags 0x08  0x8aa34000 len 0x1000
   IVMD 0x22 flags 0x08  0x8aa33000 len 0x1000
   IVMD 0x22 flags 0x08  0x95967000 len 0x1000

Without the series (stock 7.2.6), init_unity_map_range() converts these
to r/w unity maps, so every IOMMU group on buses 0-15 (27 groups) gets
them as IOMMU_RESV_DIRECT. The GPU's group (01:00.0 + 01:00.1) shows:

   0x000000008aa33000 0x000000008aa34fff direct
   0x0000000095967000 0x0000000095967fff direct
   0x00000000fee00000 0x00000000feefffff msi
   0x000000fd00000000 0x000000ffffffffff reserved

and VFIO assignment of the GPU failed (tested on F7) with "Firmware has
requested this device have a 1:1 IOMMU mapping, rejecting configuring
the device without a 1:1 mapping. Contact your platform vendor."

With v2 1-4 applied on top of 7.2.8 (they apply cleanly), the same
group shows:

   0x000000008aa33000 0x000000008aa34fff reserved
   0x0000000095967000 0x0000000095967fff reserved
   0x00000000fee00000 0x00000000feefffff msi
   0x000000fd00000000 0x000000ffffffffff reserved

No group on the system reports a direct region any more. The host runs
with the default DMA-FQ domain on every group except the iGPU
(identity), and there are no AMD-Vi IO_PAGE_FAULT or FW_BUG messages in
the log. The ivmd= parameter was not exercised. I have not yet assigned
the GPU to a VM, so the VFIO ownership claim itself is untested on the
patched kernel; the check above is of reserved regions only.

This matches the IVMD pattern in the amd_iommu=relax_unity report from
March [1] (Gigabyte AM5, type 0x22 over devid 0x0000-0x0fff). That
report didn't include the IVMD flags (Vasant asked for them); on this
board they are exclusion-only (0x08). If those boards are the same,
this series should fix them too without relax_unity. I can send the
raw IVRS dump if useful.

[1] 
https://lore.kernel.org/all/20260328213228.12084-1-chris.longros@gmail.com/

I'm happy to retest v3 when it's out.

Tested-by: Adam Pelka <adampelka26@gmail.com>

Thanks,
Adam

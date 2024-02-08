Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868F67BAE7
	for <iommu@lists.linux.dev>; Thu,  8 Feb 2024 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707406501; cv=none; b=W42IGT+fcUCEGDJtcuY7EmfkBf9pU3OxLfzgSpMjoEdk/hG/9CkZ47Ms5PHsZhRp1EwO7NOkC7scMIhdl4UaalxugTdjQGpXcJtOx4Uj8kHANBUcGOgAyit/UDbo2PajFgarz0dQYHjr7Uz3l5tdAgfgq0+SnYaP4VudTTvttuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707406501; c=relaxed/simple;
	bh=t+l40GmP0QAn/4c0/ghq4xN+7pA+v/SJsg3gMQcxNKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mc3MKnn/Hk6HjyBqajIVFOA6GNHO+4YNe3h6PS/nUQEByZIRPMGN9cq0xdXP3uf1kIrTE3LU1AMMa8Smc7H0sf/sKTClaSS134ljCCZy90pkFuNYgLWTgqoHUcSQkpJLXG7/BKtsGk+d8cxFY4JTczGOOKkvB9VJZzXOm0GRO4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MQ3HBP29; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MQ3HBP29"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c3d923f7cbso9947439f.0
        for <iommu@lists.linux.dev>; Thu, 08 Feb 2024 07:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707406498; x=1708011298; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SOzmztXeA4vVietcHAXayN5BtLIUIC76hlExobZmwgk=;
        b=MQ3HBP29aO3Mm1EO6tdE5/BgD5/pgNteuRUi30l3mj3J2mQMWKPeggR5CdS9plRIlX
         SsF3N+80uZQnH7GSlranueSBCOfNsTIeK9WGCeglx46zg5TjrJ8E2MH5bdFw7pcR+Pg4
         z+k7FaowW79eu5gFzQy3BTr7auOXd2d61PBhJ8G7Eq4uS8kIyN7hUVnjL5Py8yA2VBdD
         oteVPKpO8ap3CbGDVfP7ZJYxkvo1Sq303MIzvOncVvRra9KEyZx18C/sjr2MOi3oWXjF
         UIGbu4hru8hSuyKHjpJ0JUAHY5yTl0klDp0CgH8CZg0V54CSIM7JsLWU7A1b6RDtczNQ
         JSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707406498; x=1708011298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SOzmztXeA4vVietcHAXayN5BtLIUIC76hlExobZmwgk=;
        b=lk7zSBkLw9SZWDBA6kLH5/JrhUKe7iqyEasguAfCdWqQSSl1jHHX+sYQ5F03HEclkn
         A+/qnQJ9RBy6NPnaEgh+q2RnXl1D1cqCsJT294jbFah3w8nWmRKrOW3zIavnvGhM/1Yg
         PfRGTWyBIpcEspN5dVrH7sA+zIemC81JenmsO/GO91guRysuuBrsGhNLZATLuQBXW1TJ
         FQXflBDjAQVGMDWn0PBdPwjkZ5Es5naYNihtY6R/FDieolo9vsToMs8w/PcfAZxMXzwf
         LdFedwghUUkvo5mahTshWDSPx3VnfUdJu46vP8+fkW9NgCYuB9oNg4lD+c4ZdPj0bV6e
         Fuzg==
X-Forwarded-Encrypted: i=1; AJvYcCXp0YAhRu2D+7yp7pBWLIn1ZbFhanheMMCARZ1WnxEGqsLnVRQ12nkJ18neNZWYPARDtGT6R+LGDY+HYHSrLk+eZes0vHE=
X-Gm-Message-State: AOJu0YyERjv3fFZUGKMX7+3mgM29DZ/CglNnsFQIuUOZ6Kz4wXSjGkd7
	V27nKzdxyqWAEDa+ddj69isB084IzgZqTH+ErXPyMsoD+JXT7darrEOtsni83PY=
X-Google-Smtp-Source: AGHT+IHn9i2CgaP03XL4C5VjNlfh9cv9fEuXGoSUlZWXwvdVd3yXnN23oHf7awYJ910wLOD7Lx/Azw==
X-Received: by 2002:a5e:a91a:0:b0:7c4:965:f8c0 with SMTP id c26-20020a5ea91a000000b007c40965f8c0mr2635453iod.2.1707406498571;
        Thu, 08 Feb 2024 07:34:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWW8tQLvEMAj/grMaWGPmQmAMGh5cYxnsOdG4uvYmJGCac7GRDVOJwfsKEvGz5if4/9yK7dYDtf9hPPRJHxFXxok6n3WsgGi8Rt93Jbr8dfR8r5BFWHn4raXhpg0ELi/MDW6qFlWiHld0X8ST3xdEj8MJD90k5BfdHMdESgb5ezCJFiZJ73Wkcu5jPGJn6VoZL2QoxT3ia8K5jVSECD72xh0cWiqW2aLNuyUWEEYX7+tY0S86apKmV0QLNe+QnmRfovw3RbroS/7YZSVCMEgRWUZ/q4HVi8wj20nwAsj/ZP6qjCTVVNAw/gVlDJRIz3fGUT5ZzY6SqvXwo+6Y/0fo+MMHIZlWO6y2zi6BLpBQxip12WWosZI8dVjqWVbVpLukMN4N/2r4XoYmhKB5MaZRE0KVzTXeII7o7FaY1Cf8YcVzfvL5q/4r1fCqEqksHW3ZBD6sgFjJJvspuZEB97CCG8VXJulLewpMWAr6qkeUqFz2rayWGxLFUzcU0EVyt2yVroWvSQWpKVw7iMqJ4XF9T9Mq26D+TErzD3oLY1FPXiVkw=
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id hl8-20020a0566020f0800b007c3f4c29570sm987484iob.39.2024.02.08.07.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 07:34:58 -0800 (PST)
Message-ID: <051cf099-9ecf-4f5a-a3ac-ee2d63a62fa6@kernel.dk>
Date: Thu, 8 Feb 2024 08:34:55 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] Coalesced Interrupt Delivery with posted MSI
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, iommu@lists.linux.dev,
 Thomas Gleixner <tglx@linutronix.de>, Lu Baolu <baolu.lu@linux.intel.com>,
 kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
 Joerg Roedel <joro@8bytes.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
Cc: Paul Luse <paul.e.luse@intel.com>, Dan Williams
 <dan.j.williams@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, maz@kernel.org, seanjc@google.com,
 Robin Murphy <robin.murphy@arm.com>
References: <20240126234237.547278-1-jacob.jun.pan@linux.intel.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240126234237.547278-1-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jacob,

I gave this a quick spin, using 4 gen2 optane drives. Basic test, just
IOPS bound on the drive, and using 1 thread per drive for IO. Random
reads, using io_uring.

For reference, using polled IO:

IOPS=20.36M, BW=9.94GiB/s, IOS/call=31/31
IOPS=20.36M, BW=9.94GiB/s, IOS/call=31/31
IOPS=20.37M, BW=9.95GiB/s, IOS/call=31/31

which is abount 5.1M/drive, which is what they can deliver.

Before your patches, I see:

IOPS=14.37M, BW=7.02GiB/s, IOS/call=32/32
IOPS=14.38M, BW=7.02GiB/s, IOS/call=32/31
IOPS=14.38M, BW=7.02GiB/s, IOS/call=32/31
IOPS=14.37M, BW=7.02GiB/s, IOS/call=32/32

at 2.82M ints/sec. With the patches, I see:

IOPS=14.73M, BW=7.19GiB/s, IOS/call=32/31
IOPS=14.90M, BW=7.27GiB/s, IOS/call=32/31
IOPS=14.90M, BW=7.27GiB/s, IOS/call=31/32

at 2.34M ints/sec. So a nice reduction in interrupt rate, though not
quite at the extent I expected. Booted with 'posted_msi' and I do see
posted interrupts increasing in the PMN in /proc/interrupts, 

Probably want to fold this one in:
 
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 8e09d40ea928..a289282f1cf9 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -393,7 +393,7 @@ void intel_posted_msi_init(void)
  * instead of:
  *		read, xchg, read, xchg, read, xchg, read, xchg
  */
-static __always_inline inline bool handle_pending_pir(u64 *pir, struct pt_regs *regs)
+static __always_inline bool handle_pending_pir(u64 *pir, struct pt_regs *regs)
 {
 	int i, vec = FIRST_EXTERNAL_VECTOR;
 	unsigned long pir_copy[4];

-- 
Jens Axboe


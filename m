Received: from mail.mit-allem.de (mail.mit-allem.de [157.90.24.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B044E0B78
	for <iommu@lists.linux.dev>; Fri,  2 Oct 2026 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.24.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958048; cv=none; b=Fz21EKfWBfH+wpEPP+G5XLJa96D+LrLJ00KuLsVNdsuGP96GlUDoSumk489fpnQb2ZLWQCtpHRnh+6Gc9ch5LsjF3VfD781UHXTkvVEHS3obCfc1cSwu2U96J3IQlFnnVr/OIxDFWFqQfj+SEKSuuiUUFURKq94+Yh+2yohiepc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958048; c=relaxed/simple;
	bh=ACWsQLUHRyEN/GDh6pXCjF/EgWe7E2jMRjg1tJIFKBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HX1kqzsiGFLgAzCLAsFg4EtyoXjYjqaRRQTfALOfExvU79Gmym8D+y1tbzpqJ+nCOF8FivsKacugUTEP+CJ+zkjeukK/qeqaGLLGnFdwH3ipPXKLtqOen+oK9oBq9vQVEPuccLJP08LSp7/tEEiP1NgLUBNsVjhZCOiDMTcSxVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m-h-it.de; spf=pass smtp.mailfrom=m-h-it.de; dkim=pass (2048-bit key) header.d=m-h-it.de header.i=@m-h-it.de header.b=opLfsJbg; arc=none smtp.client-ip=157.90.24.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m-h-it.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m-h-it.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=m-h-it.de header.i=@m-h-it.de header.b="opLfsJbg"
Message-ID: <1f31f132-53fe-4f6c-95c9-c6e99bec3395@m-h-it.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m-h-it.de; s=202608;
	t=1790957532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eYNGCgretsdIj532qYQU4vdP8D7aepufvQRXZhMal/0=;
	b=opLfsJbgI/n0ZHMsB7UJMgB14IyTupFerwm1y8K4cypl6PbSC6vWeJVg3v5hJeIHuqXNFE
	cXD7BfntMmG5yJzqJ1+qtSsQAs0Uc+FjDW/vE9jfveylCqgw9wgVYhQOuUQvy9pGl4JrjH
	tqbA+oU1rjUD0rLCDaZ1mQ6bHpPf6HSggjtxOxd2v2gT4Hqv5U171pK7zpLhXA0PBLukO9
	8s+kb8I6XfohopXFu8r4hZIFR95zBvxaihqShMcw1ueZo5DNDr3f/yT/TzFXpsTO58ejUL
	yQ143liE6wyh7jsmr0GxvqlM9kjmwYYmaW03umIVO65rY86Rkcl9Mc8hFO+Dag==
Date: Fri, 2 Oct 2026 18:12:12 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [BUG] amd_iommu driver timeout (i >= MMIO_STATUS_TIMEOUT) during
 S3 resume on ASUS B650M (Ryzen 8700G)
To: Gareth Wilson <gareth46wilson@yahoo.co.nz>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <1085605364.308439.1786068627265.ref@mail.yahoo.com>
 <1085605364.308439.1786068627265@mail.yahoo.com>
Content-Language: en-US
From: =?UTF-8?Q?Michael_H=C3=A4rtl?= <mh@m-h-it.de>
In-Reply-To: <1085605364.308439.1786068627265@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 07.08.26 um 04:10 schrieb Gareth Wilson:
> I'm experiencing random long resume from suspend times that are fixed by 
> adding this to the kernel boot command, amd_iommu=off
Same symptom here, independent hardware, so it does not look board-specific.

   CPU:    AMD Ryzen 7 8700G
   Board:  ASRock B650I Lightning WiFi, BIOS 3.30 (AGESA ComboAM5 
1.2.0.3e Patch A)
   Kernel: Ubuntu 6.8.0-139, -142 and -146 (Ubuntu 24.04 base), all affected

Over 87 S3 cycles across four boots, measured as monotonic time from
"PM: suspend entry" to "PM: suspend exit":

   - 12 cycles took 30.5-34.5 s. All 12 have the warning below.
   - 75 cycles took 3.6-23.5 s. None has the warning.

   WARNING: CPU: 0 PID: 2647255 at drivers/iommu/amd/init.c:980
            enable_iommus_vapic+0x343/0x3a0
   Call Trace:
    amd_iommu_enable_interrupts+0x12a/0x350
    amd_iommu_resume+0x38/0x50
    syscore_resume+0x41/0x1c0
    suspend_enter+0x2f5/0x440
    suspend_devices_and_enter+0x195/0x2f0

In a slow cycle the gap sits right after "AMD-Vi: Virtual APIC enabled":

   [43027.178249] AMD-Vi: Virtual APIC enabled
   [43050.788745] ------------[ cut here ]------------

The intermediate cycles look like the same wait cut short: a 15.1 s 
cycle has no warning but an 8.9 s gap between two "Virtual APIC enabled" 
lines, so GALOG_RUN eventually came up before the 20 s loop expired.

I will test amd_iommu_intr=legacy (narrower than amd_iommu=off) and report
back.

Regards,
Mike



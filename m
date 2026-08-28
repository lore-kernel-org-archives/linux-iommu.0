Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE01353A6A
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787930699; cv=none; b=OGi8AcGoChkO5QwcMrBtr3Ii8PTzdXVrIYGoZGL0NWg9vsJ//OPVHufIlRPb/mGIzMh4Bo+WrP2XlSHg44/IweJq5dVHkFc6OsHZersVvPjogiFDT7H9CKbbHh3Vf+niOsf5CwU/13T/1aITvj+dOnIRKNn6MgpKPOdeCx+h0Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787930699; c=relaxed/simple;
	bh=tpyZvgdIuReJeSrdOPCyYr8fsLpfLCii8h1S1BKcev0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XvwY2xT7yRr6H24aRqVz0UfwjCJs4NvGdEqShArSnfwmLYXWp12Qtzs93aBwGC0DZliIe7nVxoTWPVKs5D/fnrXmxsdJw8vEz+kN7bzzelYhNOPQ5uVXYr1OxjWQADHKx+deZQe6NoOEQB1W9Ms7/rx2MnJS1DQGkwIyyFjP/rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pKtR4C9C; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKtR4C9C"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ca80d708489so760686a12.1
        for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 08:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787930697; x=1788535497; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y9a+pZojUOO4HpL0ROFDlkkfxxX7L9GiDlhrWObpWAw=;
        b=pKtR4C9CpR3Pl8G6Ck6Zyc7MSWCzgGtIeAeWk3d2mWTnnruqYE4FXRTQnSACPhMART
         5vwKG53EZal8F7pxuXMn6cIbLbUyfFG1Y75FEklK2Cx45GgCVWuTC9KASPYVfrEX1g9Y
         BS91s6l1G44UHad3oHeLg6VC8zxJouU2cZZz+t1DoKgGjDNVrx09hjpGTeiwkk1kOplV
         4RVR+72d3kB6kcumi8C2sgd6naUJJj9nKNO5s0diBP8N+uNUY742o8pbmQRW2JzD0OWx
         XIc14GSXEVM7VzKL5jufmK4VfiQatY/GBEwhSo5qjdXeBAyRMCKaIZ+FPcTvYQh8ZKqk
         TJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787930697; x=1788535497;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y9a+pZojUOO4HpL0ROFDlkkfxxX7L9GiDlhrWObpWAw=;
        b=U49ywxRfhSHgFQ6x32d3+9mpQA3tF+9GS+uuhCq+R/3rVMniQfM014G5C9pUKuoiyT
         xCMDP3p58zGWoH0jb5sw6rSrXtqnlpdFcbbT96J2LvK3PoHaE3iIorKea4suyVb53pKB
         X3btfvFq3hzKuCR0d7HDOwoG1TFuP5Fhc1HY3l2ojP/XfCKDCU0qrtQAY5HLZlCM55rT
         7BSoN1TP/Wlni9Y+2fgu2RRAqmAmWiRho+xJvB1nKxYVqzJ397Vkm4r7d86IzfgdWQja
         U+1KLsPgFYaQ8oKgjFnyM7wmMFpTE15aV84lvX+b2DqxF2Bq8qQOZA+RcdxBcGsyQuPv
         f1Sg==
X-Forwarded-Encrypted: i=1; AHgh+RqizhP9t09Ra2cinEEGCP7AuTe7SMqiqP9h0qNiMA7itdDUkV+a1G6wWeLLOgAQGeuNGJadlw==@lists.linux.dev
X-Gm-Message-State: AFuF++nJvn9jZ83LYqTlR6nh6gPvqccVhd07KaVp+/7rU8ZIlTJtQdt8
	+KCrTpA99GhL3FhFncU9SSgAxT9SlOJy36U/j1FcOlLho2tvfid6KlG6
X-Gm-Gg: AR+sD11bEiA6mYpbPpunMzm6QsLexE6i8vak9JFQaiwBrjVtO4/Tyl7ie/AHsfSFPmX
	K3IhyHr7FkxfCa6eD8ezezkppwTEvS+a60zwn+whGvqB2fifc7kP/W5YFmkVEROnFWLGs45ShBy
	SLZOgS3TNIf8QpBiSb9mAoG+j9xjPQNUa8UjpVqfKZcz3n/sgpMESbNg0H91JUEAcBg9PZ/8A8g
	qVD9AAWoegICgFknmVzwpfFAF+t0ys42BoXdhDCHnpMbAzXzQJ0ATN5AxKF/aU/l7IulmLTRmhi
	uKUDf+GWE+t3uv8vDpkAnIkdJL9QXGJmHZP9Eo/tEsj4ELEE9qT4D8ISYO1Uoxo2ZBxag9ba33F
	mmEdEmiDGHqywGgc0xnClpZcXQwcjSsy9i8Evp3rzRxAur4HpJElv0Bl5uLlgqewZvMyXBmvyVb
	Iz3E/jajUzDxJEbb4ELU6Y8exi/iSJ0RFXA6npZTlDx/8Rm72tVYivtWjlmKO40/VdWz6mxj/uX
	60+V8L9OgOwQGJmcEYadqAGNhbKDZxmEBypLTZixHNtRITuwU1ZURq6aB0MKMeIlxWp
X-Received: by 2002:a17:90a:f088:b0:398:9beb:a2bd with SMTP id 98e67ed59e1d1-3989beba8bdmr429233a91.31.1787930696923;
        Fri, 28 Aug 2026 08:24:56 -0700 (PDT)
Received: from [127.0.1.1] (ppp-124-121-113-94.revip2.asianet.co.th. [124.121.113.94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-328713b0451sm7412788eec.16.2026.08.28.08.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 08:24:56 -0700 (PDT)
From: Mikael Etienne <mikael1022bzh@gmail.com>
To: Mario.Limonciello@amd.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
 linux-ide@vger.kernel.org, linux-block@vger.kernel.org
Cc:
 regressions@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [REGRESSION] Silent SATA read corruption with dma-iommu on AMD
 600-series AHCI (6.19 good, 7.0+ bad)
Date: Fri, 28 Aug 2026 22:24:51 +0700
Message-ID: <178793069172.1699234.13635367891277204598@gmail.com>
In-Reply-To: <fb875f14-3b47-4d43-ae3a-0d0b17e1c64a@amd.com>
References:
 <CAHEgv3TiJUvS=Hustyem0ts8jkbFVAdzBazmPhCbv2sNnTsZkg@mail.gmail.com>
 <c5c2b503-e273-4aa5-ad9f-f7afee02ab9e@amd.com>
 <178791494900.1152725.12728124457005560389@gmail.com>
 <fb875f14-3b47-4d43-ae3a-0d0b17e1c64a@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On 8/28/2026 6:22 PM, Limonciello, Mario wrote:
> BUT the issue internally does show the issue is specificially once the
> 32-bit IOVA space is exhausted.
>
> Unfortunately; the solution is currently a BIOS change in how the type
> bytes of the IOVA is handled.

Hi Mario,

Thanks -- the 32-bit IOVA exhaustion detail is the first thing that explains
the timing I see. My failure takes 3h25m of sustained reads to appear, and a
reboot clears it completely with the same kernel and the same on-disk data.
"Low IOVA space works, high IOVA space does not, and a reboot starts from an
empty low space again" fits that exactly.

The ASM1166 write-up you linked is also a very close match: a controller that
advertises CAP.S64A but cannot actually reach above 4 GB. My SATA controller is
the AMD 600-series chipset one (1022:43f6), which is Promontory/ASMedia silicon,
and it likewise advertises 64bit in its AHCI flags.

Firmware, since you mention a BIOS fix: I am already on the latest available for
this board.

  Gigabyte X870I AORUS PRO ICE
  BIOS FB1c, 2026-07-21, AMI, platform firmware revision 5.41
  AGESA!V9 ComboAm5PI 1.3.0.1c
  CPU microcode 0x0a70520a

So whatever BIOS-side change you have internally is either not in AGESA
1.3.0.1c, or not sufficient on this board.

On the bisection: before committing to two weeks, I would like to try making the
reproducer fast. If the trigger really is 32-bit IOVA exhaustion, then booting
with iommu.forcedac=1 alone should hand out high IOVAs immediately and fail in
minutes rather than after 3h25m. If that works, a v6.19..v7.0 bisection becomes
an evening rather than a fortnight, and you would also have a reproducer that is
practical to run in a lab.

I will try that tonight, with all services stopped, then the
amd_iommu=pgtbl_v2 iommu.forcedac=1 combination Vasant asked for. I will report
bytes re-read, wall time and workload rather than a verdict.

If you already know that forcedac alone will not behave that way, please tell me
and I will not waste the evening on it.

And to be straight about the rest: this is a production home server, so a
two-week bisection is a real cost for me. The reproducer is three lines of fio.
If you can run it on comparable hardware in your lab, that would very likely be
faster than me doing it here -- and I am happy to run any specific kernel or
debug patch you want in the meantime.

Thanks,
Mikael Etienne

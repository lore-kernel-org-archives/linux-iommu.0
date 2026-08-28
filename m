Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993B7378822
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787935338; cv=none; b=Z9h4MPTBttMFeRydcQzAZOUbSFaDaockdhmRIRoYR1vr6k30uIrQgEN5CAPxMdIE9GzSFhaWyNRLbFr1Bq06az38mYO2rRbRVdWtzTVlL4MkY5OwEKCmOM+JOmet4XniQY5V8clQGIGjVShFdkJvIDN5wzzUx0uqsu27a+1Rmfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787935338; c=relaxed/simple;
	bh=iWJRGJo8GOhSzF7hKjM4hSEZnaMvnsnJxm8SvJPRXuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rQZDHRn7heLY+fcJYcb4wzIIrJcdVMzVjNYVcWb8NuwrhxvF403bj1UJsLekOFaxU99FSXCpZT9hvheYfhMsxPajHpch5NaSUCcFkEsYzsXXienvAKz38MBEGwoQ5an62VbSX11cKfMVV+gX3KYl9Q8XoiEKFcDMvR9A60imsW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebzPrflr; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebzPrflr"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7f4b94d72acso923873a34.1
        for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 09:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787935335; x=1788540135; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qltHbqH6zAk9rxLPd6W/XN3mLDgy50kN6vVpjpgbgd0=;
        b=ebzPrflreWhwKdjmE0dl6tDqZ/2IhTTtcVCpzt2Ls8vPUfjwyUXKmYU50BIKKP1aX+
         fp8vRI+GtV2FtOs8qFTV2h9crYLTYXlfSqm07zAthbzJJxV7VqNXwK/r7Z1vJRek51s5
         LihWnDzyTv/9O/u/cih3BXmdQ2gf6zA57DFTR0l7X/CN25jzhfwywokCZ6kUZy4yrKFd
         +yw6FZfKyz6FhLliP9+bq2ywz3F6MOUw3yXE2BBQhEkGMOLfGSzQU7Pv4vLbNDI22dG2
         06SavfORYg4JxyRVD1KKtVVBE34XazKM7BQtL/IUF61vJ3JS7oV2ayxZa06cRq9xk1cp
         K69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787935335; x=1788540135;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qltHbqH6zAk9rxLPd6W/XN3mLDgy50kN6vVpjpgbgd0=;
        b=b1eVkLO4mUOsHIjJa2QJAyw9tECwi7A0LMhAjeW6pnak+pI0AE72Zw2YBbC+76bn38
         0CXMSN33R8+I9x9EgbAAEy+fHnRSdb/3VvNPVL6Sz6KI2ikJKowt085eF2yvh5akF7Dm
         tdffGyTRKxIwX0/ExY5jahoo6OKf7tWe+eu9+7zNLuQyF8+b8Btonka4OQFghmvMMN0I
         /L+v/XZUX+80kJ8ekfAk+0iTcBppCBCF+oWUP8euphBKY2CWEbcEd9y/FZYhynO7qAqb
         Zbs0kGODbUl7irag9h17GG3Wc3BzVSZxQ0wcB4dqR8hA1u9OlgZfqgW1Wn7TewDdYRI7
         iZEA==
X-Forwarded-Encrypted: i=1; AHgh+RqKDfUy56edkklIQt4oERsoSh2CwPCqR4c/xVikU/l5amFM/LIGKRJHUiK6NOSe6h8XIeqthA==@lists.linux.dev
X-Gm-Message-State: AFuF++nwLAYbHcaTHoXW+nCJtcogfxJ18KQ8121wbmVigBCNpiOzmI1s
	A5zg85JEPD6pcaSEweYhsNg+cuEtae/Yr/WbfMpaMNfjntxmfRd3dn0w
X-Gm-Gg: AR+sD12OEAY+uoVs/4RGgM60tjgM1BFDsgji40smRLGjB3WR/+rDTXcCbHhfKOZJNIb
	XVZXc03lDyf6A0a2o+O+q/IGGm+57BJwl4Wr75q/WQ7NOJMlZVniFzGt6Wucv6a8fkYNYH9y/wQ
	jF1zcDFizd+13Y8ZRFtespu36GYcP1Nen3jVwPYvkgKYgORbHDdfzWbwZ1dBbCUfs8DqD3oxLj3
	3A74BUPMPNcqyqiy0X5QZM24LgGMW2SuXbenriVUVocfTAGTwFaPApPTXqPIFDYV2Y1ImkV5M4o
	HzXxkxQV2vx1Q/fckJwOr1YsOD7CjAUaF8EPoNv3cg3OxmOkZhnnC0nkx2VbhRwFDP/2kp9CMOx
	Y6e8zVMncWzwjf9f+zrYyZz6oSYjeOPHJuAbjXMFb9ZTfAJU7Snh3asOHDC0+HTxB1NvM/zZ084
	tmGMqCVkYXE9kUnUkPBiGFhA1z5B2iyNd7cfveRWp4hyYxvaEhUOYCT3PnNUYGIpoYeeeu8T1ab
	TLDnkxYrNu58OKfui47r8u9h1PCjd5srB3KpXN1qpkkYCf9cQjuEO2mUn6OUcHNNZnE
X-Received: by 2002:a05:6830:4491:b0:7f4:eb7e:c8f7 with SMTP id 46e09a7af769-7f4f2365bb9mr8713253a34.5.1787935335216;
        Fri, 28 Aug 2026 09:42:15 -0700 (PDT)
Received: from [127.0.1.1] (ppp-124-121-113-94.revip2.asianet.co.th. [124.121.113.94])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa99d87fsm1567760a34.20.2026.08.28.09.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 09:42:14 -0700 (PDT)
From: Mikael Etienne <mikael1022bzh@gmail.com>
To: Mario.Limonciello@amd.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
 linux-ide@vger.kernel.org, linux-block@vger.kernel.org
Cc:
 regressions@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [REGRESSION] Silent SATA read corruption with dma-iommu on AMD
 600-series AHCI (6.19 good, 7.0+ bad)
Date: Fri, 28 Aug 2026 23:42:09 +0700
Message-ID: <178793532947.1861819.4688629821762072134@gmail.com>
In-Reply-To: <d49add14-c8de-4b6b-9049-4a07e5692ee9@amd.com>
References:
 <CAHEgv3TiJUvS=Hustyem0ts8jkbFVAdzBazmPhCbv2sNnTsZkg@mail.gmail.com>
 <c5c2b503-e273-4aa5-ad9f-f7afee02ab9e@amd.com>
 <178791494900.1152725.12728124457005560389@gmail.com>
 <fb875f14-3b47-4d43-ae3a-0d0b17e1c64a@amd.com>
 <178793069172.1699234.13635367891277204598@gmail.com>
 <d49add14-c8de-4b6b-9049-4a07e5692ee9@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On 8/28/26 10:37, Limonciello, Mario wrote:
> By chance did this issue coincide with you switching from something
> different to the Ryzen 7 8700G?  For example switching from Raphael or
> Granite Ridge parts to that Phoenix part.

No -- same CPU throughout, no hardware change at all.

My persistent journal goes back to 2026-02-27 and every boot in it reports the
same part:

  smpboot: CPU0: AMD Ryzen 7 8700G w/ Radeon 780M Graphics
  family 25, model 117, stepping 2

That covers 2026-03-17, 03-27, 05-04, 06-03, 08-23 and today. Same board, same
CPU, same SATA controller. The 8 TB drive that first showed the problem has been
in the machine since 2026-03-11, on the same port, and it absorbed two full
multi-TB backup reads on 2026-04-01 and 2026-05-01 with zero storage errors
under 6.18.16 / 6.19.x.

So on this machine the only thing that changed between "three months clean" and
"corruption" is the kernel: 6.19.14 until 2026-05-10, then 7.0.4. First
corruption 2026-06-02.

I realise that sits awkwardly next to your internal issue not following a kernel
version. Two readings I can think of, without picking one:

  - the hardware/firmware behaviour is constant, and something in 7.0 changed
    how quickly or how often the 32-bit IOVA space gets exhausted here, so the
    latent problem simply became reachable; or
  - they are genuinely two different problems that happen to share a
    workaround.

I have no way to tell those apart from here, and I am not going to guess.

> We do have a reproducer in our lab environment that will rapidly
> allocate and trip this issue which is how we could analyze it and root
> cause it.

Good -- then I will not spend the evening trying to build a fast one, and I will
drop the bisection idea unless you tell me it would still add something. If at
some point you want my slow reproducer run against a specific kernel or debug
patch, I am happy to do that; it is only my time that is expensive, not the
machine's.

> I don't yet have any confirmation we can patch this at runtime.  If I do
> come up with a way to do that which works will let you know.

Thank you, that is appreciated. For reference, iommu=pt has been completely
clean here: 40 consecutive 256 GiB verification passes, 10 TiB re-read over 17 h,
btrfs corruption counters at zero. I am running with it permanently for now and I
am not in any hurry.

If it helps your case, I am happy to be a data point on the SATA/AHCI side of
this, since the ASM1166 report and mine are both ASMedia silicon advertising
CAP.S64A.

Thanks,
Mikael Etienne

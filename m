Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB9531F981
	for <iommu@lists.linux.dev>; Sun, 29 Mar 2026 22:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774825078; cv=none; b=O7Vhc747Y7SCm5lyISnORIt94JUDHhGICn7BgNDJZFG4F7gES+uHuHWtLmqJHWF370WePVEoT7hpxjUaLWdN18mZenFXz+Zr62q2+tRDw6yvqKjOqVlf9c4knnftTSF9phoFY8EB1KBO12gILUb2QL7bQxWlqP36eUHL0o3zTPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774825078; c=relaxed/simple;
	bh=DkXLUmcpu+vp7QMomsKqeu+nj8dpLA67HJln8CiZhFw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTUPSYXjDxTE+iYT7E7TuivyqGKL1KCBE4x5DP460wRima+a9UiLwfV/fVmWnflBZCGss35KJ9TUh0V5Es6dHbEbaU6ZVGhTqAzeFjAo9SoMmYRqjXml68MdTlyIq1HEiavMMui8CotNDahJ9aeL/71c5hWYxzRqBDxl/wvtORo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=code406.com; spf=pass smtp.mailfrom=code406.com; dkim=pass (1024-bit key) header.d=code406.com header.i=@code406.com header.b=a8s70qba; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=code406.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=code406.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=code406.com header.i=@code406.com header.b="a8s70qba"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-128b9b7e3edso1936112c88.0
        for <iommu@lists.linux.dev>; Sun, 29 Mar 2026 15:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=code406.com; s=google; t=1774825076; x=1775429876; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EmjkZkbbVjjgaCUxuu5+nE0xjPd5gN1qT4GlMrecGi4=;
        b=a8s70qba902IJt1C+A2QxvRrb27KT894eKTlHlm87wKRQyL2UDytxRWsLtrA8/Oinw
         aphGIsYZ29eIgjY3GhExTEXGpHPkXvigbohr/SHP1TzSACNFI2FxMcJhFtwiHc3toilx
         OBbPmdfZPAm3yQuVDpXH0s4x6FrZ7k/AyGsQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774825076; x=1775429876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmjkZkbbVjjgaCUxuu5+nE0xjPd5gN1qT4GlMrecGi4=;
        b=gP7QUhVWRQ8UrUbs+tHw+bYl15ogn6KepZi1hNMwUv76ZSlax+KrZUgEqwn7W9cMLF
         9ZubF+VpE/icHJfYSBBIpG2oME/VAwTU4j5LZN2hmfGD+PU76YBkoRaFAYsnMx4iURGa
         CcVjzzB+j3bVXLpipTNI+DjhblsQA0lKSDEeZD3L6mAvW01xi7wcbssDKvCMC1SO2TAt
         9ExIUMjxvaRmZPEDbB6JG2Gk6uzRrd3jbGNbb50Le+tStiKFI8Duiaf3jYTZHIaMWfAI
         RE4iwE9g1QhmhiRQwt37XoY9XqUy7ejpzMyUcGQvMSNrO+dG4K8877YuSr/oIEQKVaOt
         G4Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWsGqx8g7CzSz2m8p84M7cv6fUfCHTPq6BTsqr2HTTCDd9DjeMCWZvWzS7B44ywxcWOp57FyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxX/8k8jNYbPm3MRN//GxnA07TMV50HOpDTJ3zGwJwzErygZZT
	hPfNPFtd7UQxpZYPzfOzFphvOYEAmUxsW/nZ8mH1//udSqhMLjI93/1rPkex9K7jNQ==
X-Gm-Gg: ATEYQzyw12wkPG0OOgdZz9ikqMJFLPYD0rSOXmn4wLpOomQTqUCqDpAbOA50H6GtEkc
	LrzCkgKla1G0db84czmdDfF4vBvm3gntvIavG/Vds3MmgdDDetKSaWQA+WH3cowt6l7tWEBG1Tk
	bYEi04ZaawBWSJCUSjKJsKeM7N8L5p2OdvEN11SPn828RriAg6v9rllLKWcsFVoa5g4FFNJfBXB
	1eiW9YEMry+VWFWSecfpcRux20KV9WFpupSimwhQlGmzD6C9rTAqGs3pBpKWsJLQaXK4CUogGIO
	F35I1hYbTxRVyZrKSZ0MSMx08XE6l0+afWfMAl5KiR6lp3Nv/UtgxCFP8kSnD9ILDqOVS6USL74
	zobJ6KbjvtK9D7OLFVHAWjd04AK4xgTeo8FdJ6AkXc+TTUfAUGO8vqrUV9U8IvOEuwikuaJ/X54
	9z1qDO1e/lQaiXFMf5cpToeHq6HWKvIpqsWSPaVcUEN0Qib6/O8Mp6Haxz+wIJ90GsUEDyv9AQ1
	YS8HUzAerLrsd7jKkKYoQT6uwgc
X-Received: by 2002:a05:7022:2209:b0:11d:f89d:85a0 with SMTP id a92af1059eb24-12ab2912740mr5861569c88.27.1774825075962;
        Sun, 29 Mar 2026 15:57:55 -0700 (PDT)
Received: from ubuntu ([2601:645:8a00:6e44:958e:90e9:e30b:7ecc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab970da7fsm6096026c88.0.2026.03.29.15.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 15:57:55 -0700 (PDT)
From: Josh Snyder <josh@code406.com>
X-Google-Original-From: Josh Snyder <josh@cod406.com>
Date: Sun, 29 Mar 2026 15:57:51 -0700
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org, iommu@lists.linux.dev, 
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com, 
	dwmw2@infradead.org, baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com, 
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v15 08/28] tpm/tpm_tis: Close all localities
Message-ID: <v2l4v5imh2lmsayevxz3palyjeglpxo3qu475gjpchitgfzil2@l24ax4vevjp7>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <20251215233316.1076248-9-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215233316.1076248-9-ross.philipson@oracle.com>

On Mon, Dec 15, 2025 at 03:32:56PM -0800, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> +		if (check_locality(chip, i))
> +			tpm_tis_relinquish_locality(chip, i);

When I applied this patch locally, tpm_chip's locality_count underflowed to -1
and no IO was performed. That is because tpm_tis_relinquish_locality is
implemented like so:

  struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);

  mutex_lock(&priv->locality_count_mutex);
  priv->locality_count--;
  if (priv->locality_count == 0)
	  __tpm_tis_relinquish_locality(priv, l);

I was able to work around the issue by calling __tpm_tis_relinquish_locality
instead.

Thanks,
Josh

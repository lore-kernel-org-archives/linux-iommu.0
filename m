Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CBE2690E5;
	Tue, 11 Feb 2025 19:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302001; cv=none; b=obKOYKBVYFC0zhtRO3QaDbbXI12opV/kJzNGEktAD4ks3oYL8+ppMir/IjJg950LecXuGAsXncETY5LpkBGXZaEdKKXZFax7zlEALKn0pxRvBfLiccNHs3geoOPtDVgCwMOw0gexNYhjYraR3A2o+kfpZIn3H2m5MmOfhFPDD+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302001; c=relaxed/simple;
	bh=zY11n/8locnzNnbkUCvqokaSEOgtoe+VYyolUrGzvFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6/yQ3lcVT0yl4y1woVNZjLwXjHTSMgedxI3tjT1zU3pvq9b2lqWRHQwZpn10Vpyn4GEjXtti+/zcsOQcPgHESfjua50LD/6zlBMQjOZ4eaVXu7OgpE2F/2+OPOJaQcvcWofEXiVa9CPc76IHe3YtqwD2tawpRhmqizB2nZIruI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRN9JBC/; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRN9JBC/"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38dd93ace00so1712375f8f.1;
        Tue, 11 Feb 2025 11:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739301998; x=1739906798; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHUiGt2p3SNBSvSE4F77dmu0tTDl367av9kzRSudXp4=;
        b=PRN9JBC/k+pwUwJZ8Jlr3bm0pvjbQXzj6sXGI3XwagGzJtaMN/uDR/AkSHngu5wOYg
         xT0jjkJ+GcNRCsr0ulkFKA33t8sRdvGYkixu3i58Nubl04GZd8iss1UePbHhIbiEEr0I
         4DtnhHm3I3kWi6FNI8gJaJZjBZ+H3W48Kluzqw8Lzpyw231jcEjMdPTHJ4P7DNEgPriT
         fA5F/H5fSc+5VbunogC+KTOYTvQLTDQG2CtSaBucgFSkdfl22RYqpDf21Tzl/3fUpuky
         Xn9kNTrGkCEL6YPutFrTAGkIqSh5DiGwQObfTMi5t4JxF6Ht79DHBtSlbPsk5sXyrxyu
         fDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739301998; x=1739906798;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHUiGt2p3SNBSvSE4F77dmu0tTDl367av9kzRSudXp4=;
        b=Q6Kan0LfphnnBct0pMLNRhNkQ20w0UikiohL5UpWTnWhKy1k25aGmwyoJrbsY4KEEi
         CD6fugvYQBsjgJ2D58+lsaP7wuG9psfZA3wcY3r+96fafwtU5Q/4We8DQPhkoWmZx9R2
         jpsd8YHMJS6e6wUOOGDUAHgvGXe+Vl6hoLeIPcV8Wgb9nNS9UqylwHlJjLu0AjsWptKW
         LjiSP4hWr98+nHnM3+YtLjEEcy6dfYFQuk/BwbKJFLMvC8mTU15aUKX1oUVicPbLTrbk
         6d+cf4pogtuXtyFPM/Uos6jxV9tU6MbToG1oIbT7g/OTxTrVqVw8lv8o0cu9YvEuv7ho
         s0Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUT3ZkQ7RMM0qGa3RTe/CRldL8vMX1LtU0njZa3Eg20SQaYp8HxQMh65VpQ2MlvhViE4736/QXWoWrUxew=@lists.linux.dev, AJvYcCWdriVHF2wUpbC1K301rtVLaO8pCAGE7NXu/T5Ov4ZWQc+sd1yjVubEPqq+MvzamKVU3Q7R4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzO1q6rCYo1P/z54VV2zTj7/zU05VPNIjKa5yULUBlqjhXYmMmb
	w/evo/hiiFIZa79UMwjnKE6VhWna36YcfvcekDUBdZ9IImZE13TZ
X-Gm-Gg: ASbGncstxQaRtK6zBei7zW3ZaAH16iytrtqdh0z047MPyhqkwakWYO1veFG1FeZnZAP
	IieG1ICgBGhRDlpXQK6Ivdid+lbOJgbhualcwY5DwSon20ENZZb7v5deGfLbZ7dKzplnYunyKwh
	4e26iDOcq3wOtDIRvxVBy6r6XjiLAVVG7SXeWI1UNWdcTem5p4M3RoGDpvT2FZXD2O9b1CZrALv
	gzGWj3IY4uTrNE8bJPKH7tULcW6hgBvB3LA0dR3chO0jPgJK8EK4xW6VZQipSDDfhywneLjg5wt
	x/0EvlRGFuFJ3PpRyyTOwW6P32Be5OswD7qQjYpLyWaTv7jD
X-Google-Smtp-Source: AGHT+IGyH6u7C+JHOMK24CSqsOZoQFhGFN1iCccM/JmeDZM3j0hw0pWZnQFg6iEPrhN9OMVzP5k3xA==
X-Received: by 2002:adf:cd87:0:b0:38d:cd8f:db00 with SMTP id ffacd0b85a97d-38dea28e259mr153109f8f.32.1739301997477;
        Tue, 11 Feb 2025 11:26:37 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcd0fac67sm12549012f8f.54.2025.02.11.11.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:26:36 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 1230DBE2EE7; Tue, 11 Feb 2025 20:26:36 +0100 (CET)
Date: Tue, 11 Feb 2025 20:26:36 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
	Radoslav =?iso-8859-1?Q?Bod=F3?= <radoslav.bodo@igalileo.cz>,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Subject: Re: [6.1.y] Regression from b1e6e80a1b42 ("xen/swiotlb: add
 alignment check for dma buffers") when booting with Xen and mpt3sas_cm0
 _scsih_probe failures
Message-ID: <Z6ukbNnyQVdw4kh0@eldamar.lan>
References: <Z6d-l2nCO1mB4_wx@eldamar.lan>
 <fd650c88-9888-46bc-a448-9c1ddcf2b066@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd650c88-9888-46bc-a448-9c1ddcf2b066@oracle.com>

Hi Harshit,

On Sun, Feb 09, 2025 at 01:45:38AM +0530, Harshit Mogalapalli wrote:
> Hi Salvatore,
> 
> On 08/02/25 21:26, Salvatore Bonaccorso wrote:
> > Hi Juergen, hi all,
> > 
> > Radoslav Bodó reported in Debian an issue after updating our kernel
> > from 6.1.112 to 6.1.115. His report in full is at:
> > 
> > https://bugs.debian.org/1088159
> > 
> 
> Note:
> We have seen this on 5.4.y kernel: More details here:
> https://lore.kernel.org/all/9dd91f6e-1c66-4961-994e-dbda87d69dad@oracle.com/

Thanks for the pointer, so looking at that thread I suspect the three
referenced bugs in Debian are in the end all releated. We have one as
well relating to the megasas_sas driver, this one for the mpt3sas
driver and one for the i40e driver).

AFAICS, there is not yet a patch which has landed upstream which I can
redirect to a affected user to test?

Regards,
Salvatore

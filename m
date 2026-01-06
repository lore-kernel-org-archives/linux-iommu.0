Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A55A21420B
	for <iommu@lists.linux.dev>; Tue,  6 Jan 2026 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767717923; cv=none; b=fnEmwYdWdjw6moyIgXws7gUmgS3Kz22TAB9LF5YB7kBuHr0O66mtUNoYGesSjAb4Y9tlcOb5kDmZLMCYDXcG2SzfXoBD7bx+LQ7NVDqqqTQEl1Xbu0GjRDzD+pJwU73bnR6yefI6cUzabsPUxXf3Aspg9FFq66Qri/25HpHzmTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767717923; c=relaxed/simple;
	bh=lr8K38rCRYqbFkBZvo/Mqed9J2BrSDyavVcPLEduObY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apeBIIyRIoPfzhw1b68TWZVvGZeZPkmSoYzZWL5HxciOmLPbD6BjZ9YeZ2vrSwcOFUU4x/zz+YMilIAM1P/hVSdQFXZECl710LLJcdV7pbas4tsSLrPRRn8LMOKRnuiUL/KMVOPbT/K7vBUBxQsNqBaFHx8fVoOMat8gRFgsiVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BwQ1nMEJ; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BwQ1nMEJ"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c30365ac43so104809385a.0
        for <iommu@lists.linux.dev>; Tue, 06 Jan 2026 08:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767717920; x=1768322720; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lr8K38rCRYqbFkBZvo/Mqed9J2BrSDyavVcPLEduObY=;
        b=BwQ1nMEJ/Y1siteoXZ6Rexodc9K2mqGoVFhQoo2pZdx7Hgh4L/jnrg48uzY2hKOX4b
         gqxNib4vdV1GJUK1dJfAUeWOEAWA78DcLfECZxMA+xSl6uRlAo6CDGgffyxwWUUbVAAR
         FsMb1CE8CJLficJmGYskhjIwPCHBxQpK5IVRoLCt8YgyiP51pWH7W5cCh+5hudSEaTS8
         /yZG4f30INuz4mFwwoH3MYTxWyrKUxwDXKFfYvSyZl4A+xCyu0J3M9VEy+9aq6f2+W4M
         SilQtEcivTUTM5h9s1cDkQJe0yrBgpgFpd1D7fR5LvnwUk7SOf4vYst3njMQQ2+QniXg
         TjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767717920; x=1768322720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lr8K38rCRYqbFkBZvo/Mqed9J2BrSDyavVcPLEduObY=;
        b=gPZKdFS/6wMDQr0q2jKjHiAsBHJfWKW5YfuoVqDfxQtqdg7K0vgBonkMTZjWTiMgBM
         rHOV5j5zaYJDDY/NViVT62PQp2XYURFp/wPWxIA5Sz7q8s4vLkF/qV2hRZUCNIODsWQC
         uY/ijUXQ3uaOU+esSq0b//X4WC1cbwZjmfgCYbyzff3+S7bi+sWTC51ukWxdedLWcmyD
         anxbayW8Y5/0pyqNeAFo7JjNoHqPucHPFUU7tfimbB08StFb+7gEgNHgVjaxUeVn3DTY
         NNyDUCXlIHmD7xO7+XGugLN4DtRKpkratweQ2wEd0h28o4EaSP6JWRe+xC87ypwJSMen
         5A9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXQlVrBYgfeDbSLJj7n070VpqlRWaKshiBsExsc97tXa7Rz3sMIj+5jN4MDlI6onUFwubDgw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUEZli7DDoSswyRZrCgsdbENfLYji5MxMWTf9170Xldm2Uykhf
	mlCiiceIkhtqgNk+P/SpElf5SZLCY23n+CZmCh1hs76qh4Lv3O1MB0urk6Kw45MVSNI=
X-Gm-Gg: AY/fxX77r26m1rx/mdXnGDGoCWM0fy5H7KUrLwi1fkpA67QBvjlUqpN6rqZ78R14FJY
	ZVOCleF7QG7Xh8CEcYInhL/agAYOd8+peudEFMZ+SCthDeaZCikbHX2wgoE4V3IV3BiVOKoGiMY
	wqCEEzQyO5D9SxJZX7AE49cJIvCydFS4jKPSUB/sFKtH9FE0d8L/HqcGu24tQZBQsGQiFoEkQ+8
	48cT8pfsmJUQfyPVYGBYSb6N/yTuITb2knRjIJ/9nKae/z1KDWhH/i9EGEqv7sFloNkRymmAxEx
	JAZkMmDn+Tua5MuuFWRDPm1FOlIU1qEM9Snwhz/RBU5Q1b9CShoVjm9FtCZ/jtj/hI+xNwEC8lw
	pgutvsweFgurBnMTbQN+wtNUWY+7p2lo1RnN/csslgcVQ3vrbP/5tDCsFyTwiQBhQqW5p0fjxh5
	BTF1ytwCohiObLg6cPraYnmmMJO3NfgtS4aUDLLnRKx1rlblXBMfxQtN331XC6oJZRypI=
X-Google-Smtp-Source: AGHT+IHVT2tGeglxMO1YjfKgvviNmlrha3mULKozHWi/AntTDW1jQ8xZvmVZwiDZFECVx/4DFoWwqg==
X-Received: by 2002:a05:620a:4724:b0:8b2:e179:feb0 with SMTP id af79cd13be357-8c37ebb8549mr429998585a.86.1767717919908;
        Tue, 06 Jan 2026 08:45:19 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4ccdf8sm198944485a.23.2026.01.06.08.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 08:45:19 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vdABK-00000001cAp-32IF;
	Tue, 06 Jan 2026 12:45:18 -0400
Date: Tue, 6 Jan 2026 12:45:18 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dmytro Maluka <dmaluka@chromium.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH v2 0/5] iommu/vt-d: Ensure memory ordering in context &
 root entry updates
Message-ID: <20260106164518.GA340082@ziepe.ca>
References: <20251227175728.4358-1-dmaluka@chromium.org>
 <20260105181200.GH125261@ziepe.ca>
 <aVwI_SHHGPl0xndu@google.com>
 <20260105191410.GJ125261@ziepe.ca>
 <aVwZkFQ-iQ7OHMi2@google.com>
 <20260106001418.GK125261@ziepe.ca>
 <aV0TalseaDGW-1Jp@mitya-t14-2025>
 <20260106142301.GS125261@ziepe.ca>
 <aV0vM9ad-4QhCNaA@mitya-t14-2025>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV0vM9ad-4QhCNaA@mitya-t14-2025>

On Tue, Jan 06, 2026 at 04:50:11PM +0100, Dmytro Maluka wrote:
> So we'd better make sure that if it happens before the barrier (i.e.
> when the device is not supposed to do DMA), the compiler (and thus
> the CPU) doesn't set the present bit, so it stays non-present, so
> the IOMMU will block this unexpected/malicious DMA?

It is true that any write to the dword containing the present bit
(only!) should probably use WRITE_ONCE.

Jason

Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5103AE190
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863541; cv=none; b=JjIYic4+g5IvZqb5xGlQDQZT1pBwul745veh/4nuFz7nqMmH24oXacGH7XmgwrtOvJo0zm9MQ9moxdbgNsY6CE+A2Se/d4pCa8bMaddSn6exzZR2JJq0pMAZQWOE662CztiVTRm6Va7dOmUQd1kk0lzTryuAaABodUVq/+kB3V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863541; c=relaxed/simple;
	bh=MTNOj6ynMachv6R2Eweg4n7R8rKOuF6OM147NJPcIrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxpBVLQM51ZtyBUihBfArPzEQLymy83yzpVeCov/zjLLzpoDJG8E54O8JwLdnxq5XRUG2rvzoC0DhbIoa8J6v8EVL3OMyAlhG6SWek/V/RX/UEBJErShzqlP4kccCc7wySGAP5DDBw14gm08CdepdNyZJq5gvsGoGHcr59UjNNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rEsmyooA; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rEsmyooA"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b0b260d309so118535ad.1
        for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 02:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774863537; x=1775468337; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vWT7ljauT3GJtk0p4Kr5YKMZTjRAnUxPGa2dI3sggKc=;
        b=rEsmyooAaumKuJpvARcsBLQ88qtbjsRmk9gGQHEyQICpZxBd4xsuwfpvTzkPxvC03F
         VX/MjMgiCxb4f3c4iUTTAfLi4TV8poLNbPkmsmD4636LX08if4hsQ6snmvz3SzZmI3tw
         lJglcSQAsDQruL61pD4DlKd9txXdxXGP02ss5d1XcZHOcbFWCRtTARZvPKTKx2kAjsK8
         kaAc1RnAFxv8AcI6D2Xr/ysydQet9COz10Irx7wJheI9IZCBK/YHeS5RMLSVPl4bfchw
         i+vf1R2/0C2wYHSRhZ9IXelQYR8XvjD4a/okxk7tsrlsF4BeMOEIxpRcHDMvCu4Hr7x5
         yaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774863537; x=1775468337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWT7ljauT3GJtk0p4Kr5YKMZTjRAnUxPGa2dI3sggKc=;
        b=tAVHhvvoLTuS61fbi7WG+H/OsPIzLVjyQiwNHf26seEGNK7X0yxvRgmYZ4C/21sVYY
         52UnG2hfeUg4N5MJrU+dyFpIjRYi8R65DvC3md3sE8dj9LEHUTbAMc1LGeya2C8bOIAS
         dguGYMVg7LCpCIJgqaYjdscuvO2rixrpqAIGgjFQaSfjsg5HbVQoYxYe8CLjqQgUwi7n
         cEoWLMQFusFMvijtMtWRETDYLyyFACic3+XDZ34Zmz8YoFEhHtsT6s77OvxeHN4avbkl
         ub5KcLgwBnQemT0SSjbOhsatl+rgRt5JO76jy1gQRK0F75lv+6TdJO02nubts7mSJxX6
         Cx9w==
X-Gm-Message-State: AOJu0Yxd6p974FOHI5wSQ2CGj4DBxurlHfyU1HeollIVg5PyiKHAtGPb
	dlNKw0NlnSnPQq1q6g3/4zamb3LNT0TQDUdz1w8VHpmAC+Ot9ZY7WV08E7Q6/miLcQ==
X-Gm-Gg: ATEYQzxz1uOdji2ezUbB6PHFyJMTqSThy74aWZMfre+xbA8nd0b4oK2m88+GVrXQkS5
	uFMXVyvDLaDQPTtSg3qMhcp5VEs8FSs95Yv62klXOxvF8IyiT3iFdRVAbVoiWGHnmOCYhYTHebz
	YVwmcY7vLr3LqGzyT1uyXJngzmtIIrPm/9MehFonZ/W2wje8QnkTQYTXG9rrsb4tvNduFo0+yOl
	0SR3nmAd7Kv//ha7hvIdIZVh7NvEBc+Fp2PJYbFokc/Cc3TuTwGUZF7D13mGsBgu7fMRPlNoFkK
	hTqBF9MLE787OJMyw6p0DfMnLeNaJWnZ0gzyzU48YirCi8bEhbKnZwdUQxrHyPtTdmkCnx1sVTN
	zROG0Mq6Ma7tGsojaVpXjAOWZ9m6MfOZ+h7EY3I1WpaDZOKLytL6zpdpRbuzCnCREirqh8Tjs4b
	KbPn9JZXJw9Fo1qrhEPBJ5z6QJkzPKj+oNJ1OeoidTg6wlVbsYaODKMmgNqlCae8oU/dkV
X-Received: by 2002:a17:902:e54f:b0:2b0:b458:2dc3 with SMTP id d9443c01a7336-2b242d37d20mr493545ad.21.1774863536692;
        Mon, 30 Mar 2026 02:38:56 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242765b9fsm88519465ad.43.2026.03.30.02.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 02:38:55 -0700 (PDT)
Date: Mon, 30 Mar 2026 09:38:49 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
	kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, baolu.lu@linux.intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] iommufd: Fix return value of iommufd_fault_fops_write()
Message-ID: <acpEqc61YLOwrgzm@google.com>
References: <20260330030755.12856-1-zhenzhong.duan@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330030755.12856-1-zhenzhong.duan@intel.com>

On Sun, Mar 29, 2026 at 11:07:55PM -0400, Zhenzhong Duan wrote:
> copy_from_user() may return number of bytes failed to copy, we should
> not pass over this number to user space to cheat that write() succeed.
> Instead, -EFAULT should be returned.
> 
> Cc: stable@vger.kernel.org
> Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

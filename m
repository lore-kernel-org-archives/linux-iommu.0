Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2522750F3
	for <iommu@lists.linux.dev>; Fri, 26 Sep 2025 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891763; cv=none; b=cCO588SEKIhZR91kruNrtuRujLnO/qVyec5r30+Rn/F4cKaw4fo2uMdnAZKRwA3poANg0V6IoBcm+N2IElO4j2N8panhXoOjVmDiAXWLPGRWtCu6C8nSvAaGGsvmVhi9jup2xZkSneEpGId0a85xGS4+FyCutWdr6XgxIIS5d7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891763; c=relaxed/simple;
	bh=ptNXivIz/aNnUiIKkLbB6u3iiGGkTOcWckQJm78UoEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWJImChAhc7WQH7M7SGtSNK1L5KVYTSKx6NeCieZi6fVGUICQmgPllsVIiiUXOgjWvLwYaDVg/mqOHytcrfmGc5B5Zwg/pXeVdYO3QVq2GsypPmEMpHGaWUzYIzpuRI5PDXCAhWmIw8Pi9dL2a6TZCSsfWRcsqNH7w+pReFtnzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ePCKsyXN; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ePCKsyXN"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4da72b541f8so27229331cf.1
        for <iommu@lists.linux.dev>; Fri, 26 Sep 2025 06:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758891760; x=1759496560; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wWqwjGIjU9SQRKUcuqoad/3ZN7TYjVFKb+KM6PbNx+o=;
        b=ePCKsyXNXXF7hH3ufFMoW6SupXU4YWCjfAyZaMtfymJ2qWUmyCpGs7Egf9B410KMxt
         y5l9NRWhNVtf+5eXpMVSf8AzDr3BmoED5ldafsG8XDvQO2haESsv057upFDFVktkvptp
         8iLX2wmx2SvKxSMR0/SP21JX1Gb4dhg5CbkmN4La/KSAICog6DfWyK6dIwMWTzJ9zbvG
         tOKsAWA+Svm5/6SR0iRUDga1+W8Ho1i3OaFwtbaZRhAOkooO4+HpNstJn2Zd66sg8xjs
         FFDdISh9mlySBtcU59gx2vx5ChU/q8CIQt9o1i0KwpBucsabXMU+/u3e2vPikgn/xQGz
         Fttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758891760; x=1759496560;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wWqwjGIjU9SQRKUcuqoad/3ZN7TYjVFKb+KM6PbNx+o=;
        b=B5GV9lC+jhMJSeDtYohAPlMHS/Omt7Hdx8Xln/RUfUcaRanxfRA5Jst/cy8n9OO0Zp
         Ceqhg8dPTQldAfwS79CZPpM21FVny0EPD5tm29mGivJuGwpOsSD+SVPM2Dop13PLBQ7a
         oCeTzqwhw5ZMuhzJ90yiT5x4alwJCIp63iyQnabQJwwYSbMvBoop3GljQs4Kz3yKlePB
         GsClv+gkL2RA8Hzwdp+5jophMs6CFqJeisTYCZrOSEDTWUGhBL01cc0AjIELYpFrARlC
         2aKNKG31bw/GWWsOHRv7p2PhhREqtx/rtA8o3KWHJMh8dLlMunJq+G8xhorsGm2AXtyp
         EI0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzw7PNI8UIoLWLqd+auDJJn0/tHpNpFUMDwOI2bwSKNJr3gudWL6olY4d77Yy1w+z/0HnSMw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIJWiAWfpHBs4WX7J7opfyMO5TPzkmMgA/r/jrkuVFp9qNoO4o
	M/nQoiNUFiHit5V1mDreU+6ozJbGtL2Gzgq7RNZQDTkB7nBxm9a8s1YMifS8XA5Ueyg=
X-Gm-Gg: ASbGncvgEWaNdCd+tODrrIeKQu2O1AsAngaQxO9ijFXhf2IkjAwayajnHX3g9c4Hv8+
	g4/vti6eL6nR1Ce4lQF2X9r+qq7QdstX9WC1mYbXvEosnQKrYhaHe6ZGMvg18Af4NFOc3zaxR0c
	Q+qolAEs90lyd5ZR4QRR5xgohmQfoOkTVxhR8izVzrqisnQgbpfv7Dxa8ANKrWLyDXsXNBYx9rm
	e1ZJViJ9RijykSn1XM7TdrU4V7IuLyaWrZw558rSFQFKBFE6rvd/AgTxGTQsT2VRvijHcNZKG/+
	ejn9GxkVL1Nq4QwZLUkQyLwt0KnEpZQNkrQGDNZlas/DXolw/iJLdn+l7ooWyRtvm2Vh5ojConv
	sNqqlrseVbhrqCo0c5B4j2bzfuHZQEE+xoFvWBi4C1zoxtk4lPQ/Yh4ICQJ3hkdiD20NLr8w0P2
	sVKLo=
X-Google-Smtp-Source: AGHT+IFG6IrC3E1ZMV5IfBX1Yz/2jeOobnkaeTVu8VbWTtPw/mqYHCeluPzzqGEyM5aIpdwAOBQfaw==
X-Received: by 2002:ac8:7d8e:0:b0:4ce:dcd9:20e5 with SMTP id d75a77b69052e-4da4c39b63dmr93170581cf.61.1758891760125;
        Fri, 26 Sep 2025 06:02:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db11cd52e5sm25939731cf.47.2025.09.26.06.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:02:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v285t-0000000BmNC-3fwI;
	Fri, 26 Sep 2025 10:02:37 -0300
Date: Fri, 26 Sep 2025 10:02:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: kevin.tian@intel.com, shuah@kernel.org, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/iommu: prevent use of uninitialized variable
Message-ID: <20250926130237.GA2695987@ziepe.ca>
References: <20250924171629.50266-1-alessandro.zanni87@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250924171629.50266-1-alessandro.zanni87@gmail.com>

On Wed, Sep 24, 2025 at 07:16:28PM +0200, Alessandro Zanni wrote:
> Fix to avoid the usage of the `res` variable uninitialized in the
> following macro expansions.
> 
> It solves the following warning:
> In function ‘iommufd_viommu_vdevice_alloc’,
>   inlined from ‘wrapper_iommufd_viommu_vdevice_alloc’ at
> iommufd.c:2889:1:
> ../kselftest_harness.h:760:12: warning: ‘ret’ may be used uninitialized
> [-Wmaybe-uninitialized]
>   760 |   if (!(__exp _t __seen)) { \
>       |      ^
> ../kselftest_harness.h:513:9: note: in expansion of macro ‘__EXPECT’
>   513 |   __EXPECT(expected, #expected, seen, #seen, ==, 1)
>       |   ^~~~~~~~
> iommufd_utils.h:1057:9: note: in expansion of macro ‘ASSERT_EQ’
>  1057 |   ASSERT_EQ(0, _test_cmd_trigger_vevents(self->fd, dev_id,
> nvevents))
>       |   ^~~~~~~~~
> iommufd.c:2924:17: note: in expansion of macro
> ‘test_cmd_trigger_vevents’
>  2924 |   test_cmd_trigger_vevents(dev_id, 3);
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~

Shouldn't word wrap output like this, ignore the checkpatch warnings.

> The issue can be reproduced, building the tests, with the command:
> make -C tools/testing/selftests TARGETS=iommu

    Fixes: 97717a1f283f ("iommufd/selftest: Add IOMMU_VEVENTQ_ALLOC test coverage")

Applied, thanks

Jason

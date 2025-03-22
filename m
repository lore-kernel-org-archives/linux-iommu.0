Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C4F1DE4F3;
	Sat, 22 Mar 2025 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742644219; cv=none; b=UcMiiZ/LG3y4K8zY5Y8pVELfz6SrM0elZsf+nB8eP9vvlw+jUGhRrrOKNkMUJuZ4qNb4AlxhRqlpy1s9iZTq88a1MfJVdifJbtH/Ab7FQ5olesicqCfeFeL0YPUH/xUad0je/Des95EC9omPtfaicDgr4ZfeyTakbEXCXPIdLUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742644219; c=relaxed/simple;
	bh=dlb2c5+73X9T17Ga2GDXTcwT6vGIJCUSgIzW59AQZWg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=rNu/UdTsJ1c5pdO2yRzhP45iGJGLb6WzIYPtw0M5oFFy3wcgFisFPOYlutfZE/oHwYCEnXBiXmd48mCJKFbC0lKX6u1dQxSe6SoWFLvWzDAFHwwzMrTb4gu5ewn9ETXTXhvFoOBukzapP4an6O01Jq2dt12/zbui0So78zMC6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4Xzk5w4; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4Xzk5w4"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso483215366b.1;
        Sat, 22 Mar 2025 04:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742644216; x=1743249016; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JeCMKd6FN5Dtrxtkveh1+h24l/CzYAUf5GBYjF0Tj9I=;
        b=A4Xzk5w4EXnoVG94lGIjGSKHkTnSKgIhUlxXD+gFGkkbghyFa4JrVLjYRFYSEKmeb2
         ingyA60KO5YKX9/1Lu59qcQQQFryAM1FYS5czlhDLXdEi9WLBVFWttrHsZxdUEUdI+0f
         CPUyY6MKYTgi14L/kVFlj1lj6mR21VhVU/EboqPnfNSewFHT8x2ZxyEWQtnAqRRp1JHe
         3KM3xVqhNiAIZ2PzshJHW8HPXXHZVubrHZSE4W4b8GTsS/JKVkGR8efQetqZGN94hJ/t
         AdHgJy1rlZS38inW3YyvTwU3/QGTUhkG2ij1uGzV64jy3BlMH5XZBaXGlXl/xW9XSl8n
         aUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742644216; x=1743249016;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JeCMKd6FN5Dtrxtkveh1+h24l/CzYAUf5GBYjF0Tj9I=;
        b=ROMomKLZ9SbtaJMuUQ2VhTY1zOD2uDaRO6/u1oeFA3FiY3TahWbFRowyO29PhcPsQY
         zhc2i1uTyRR07UbO8vP6p4ypfjVsU9KE2TKD98C3DKi0wz95+i9Zvo4D4UY4fVzN9l2n
         dXQjhFzg33AL21ax5CiK3g9g3DOmXNpMTM3QsVG2QasYgdsYyVINjm4B86zO+zSxhlmo
         0z8iRJUA+xsR3YUcANsSaQ9OEldNKLm84CuzR6TV0S1HJd7ozKRLfY/42Nb61gpKrmyt
         qj+O/JOHN2y4dKhNl/H6FRSg00RGWNjOkuscqR2zKdJZuiPsUBeppRKK/G4yuLbbLhtH
         YpyA==
X-Forwarded-Encrypted: i=1; AJvYcCUlJ9dS9TfYQAjV59u0jDR3nTzNkXFylAN+iImgSfXAPL2C/cKYXMQ29HCcvPdf1U1/ETn0obgZAMagzw==@lists.linux.dev, AJvYcCV6Ug8JXt3b+9Cju0sH4OhwaoRhdUY90rxO1w1ZnZ70wV7jRGfMY4d0ij0MuTKFbqsumF7QTw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzF/e/Pqzfx9wT/k6hHjuDUWFQ3umi4gfXT40SBfzB+Z+CQDhGM
	rwNt6YCaRnfV1a+GXL1G1EySkd8fv4FdhsbSyYGwaNI64ib3U/Af
X-Gm-Gg: ASbGncsQVvPklXHmNFjkDx3naEuOS9d0/MgrplP24UFTyI+waZutM2dO0FOzHMntAZv
	NW4UiJe+OWFgTVhTtQZwCIKyD4RvtPV1+0DXdGTu/0ZeY8VOgIi1cv6BFQgTjPfUruJiCC+/DzT
	UHXghd9pmKua5qhUDoQhiK/g3u4lKYDtVfGzF3T4SDH/2ZDEM8EOQZXBhOr+yo6O1Gs53AkubW3
	w4BBut9SmXV4T/MSRmPBPzR0xUFWOMC2grEH7BVQgkcn8bZkRrAaZIk/Arp0+Cmo+9O+qagvJ+2
	e6TcyxODgb6IBZyPWd+ImZdgRRcyUbIapOoYKp1iazvD/3TPvQ/2DR2OlyEEbaVwizKm06J7E2v
	IITCRn3aEc/qhUwKbum+hMHo=
X-Google-Smtp-Source: AGHT+IEphkVCVCfxAVXmQkZdk1aaFCEcND/QMO8xPKoiUSmAYimS0LjW+bLOcrDDhpSGnYro5fRwfQ==
X-Received: by 2002:a17:907:ec81:b0:ac4:2b0:216f with SMTP id a640c23a62f3a-ac402b024c3mr372266766b.43.1742644215830;
        Sat, 22 Mar 2025 04:50:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:5d29:f42d:82af:f891:3144:66d? ([2001:b07:5d29:f42d:82af:f891:3144:66d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd4798dsm326399066b.161.2025.03.22.04.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 04:50:15 -0700 (PDT)
Message-ID: <7177c7ae24b9f7ebbfc001166e09beadb81305ae.camel@gmail.com>
Subject: Re: [RFC PATCH v2 05/22] crypto: ccp: Enable SEV-TIO feature in the
 PSP when supported
From: Francesco Lavra <francescolavra.fl@gmail.com>
To: aik@amd.com
Cc: Jonathan.Cameron@huawei.com, aneesh.kumar@kernel.org,
 ashish.kalra@amd.com,  baolu.lu@linux.intel.com, bhelgaas@google.com,
 dan.j.williams@intel.com,  dionnaglaze@google.com, hch@lst.de,
 iommu@lists.linux.dev, jgg@ziepe.ca,  joao.m.martins@oracle.com,
 joro@8bytes.org, kevin.tian@intel.com,  kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-coco@lists.linux.dev, 
 linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org, lukas@wunner.de, 
 michael.roth@amd.com, nicolinc@nvidia.com, nikunj@amd.com,
 pbonzini@redhat.com,  robin.murphy@arm.com, seanjc@google.com,
 steven.sistare@oracle.com,  suravee.suthikulpanit@amd.com,
 suzuki.poulose@arm.com, thomas.lendacky@amd.com,  vasant.hegde@amd.com,
 x86@kernel.org, yi.l.liu@intel.com, yilun.xu@linux.intel.com, 
 zhiw@nvidia.com
Date: Sat, 22 Mar 2025 12:50:12 +0100
In-Reply-To: <20250218111017.491719-6-aik@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On 2025-02-18 at 11:09, Alexey Kardashevskiy wrote:
> @@ -601,6 +603,25 @@ struct sev_data_snp_addr {
>  	u64 address;				/* In/Out */
>  } __packed;
> =20
> +/**
> + * struct sev_data_snp_feature_info - SEV_CMD_SNP_FEATURE_INFO
> command params
> + *
> + * @len: length of this struct
> + * @ecx_in: subfunction index of CPUID Fn8000_0024
> + * @feature_info_paddr: physical address of a page with
> sev_snp_feature_info
> + */
> +#define SNP_FEATURE_FN8000_0024_EBX_X00_SEVTIO	1

According to the SNP firmware ABI spec, support for SEV TIO commands is
indicated by bit 1 (bit 0 is for SEV legacy commands).

> +static int snp_get_feature_info(struct sev_device *sev, u32 ecx,
> struct sev_snp_feature_info *fi)
> +{
> +	struct sev_user_data_snp_status status =3D { 0 };
> +	int psp_ret =3D 0, ret;
> +
> +	ret =3D snp_platform_status_locked(sev, &status, &psp_ret);
> +	if (ret)
> +		return ret;
> +	if (ret !=3D SEV_RET_SUCCESS)

s/ret/psp_ret/

> +		return -EFAULT;
> +	if (!status.feature_info)
> +		return -ENOENT;
> +
> +	ret =3D snp_feature_info_locked(sev, ecx, fi, &psp_ret);
> +	if (ret)
> +		return ret;
> +	if (ret !=3D SEV_RET_SUCCESS)

Same here

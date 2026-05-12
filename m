Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4BD3AF646
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617720; cv=none; b=X8br3jSySxoLQ0eKd3BIT2uDPSKJz+up8S2j0nW6+t51bQfz6l9NcAVgWlXC5X4/DYwSOZZixnjoYchCGzpjIdUcHAm6tfnLAc7WsY9h0QSH3crTHnKSmQpTfAnm85OIVchsvh+JrQe6kh8yLE3bfUodBh7pXoDAXY4ZNVj04GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617720; c=relaxed/simple;
	bh=ZdFCLTngGpWA30C2bWFo2s/6cKEcVqUVdYFFi/jmxbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBDHEd/WgilelCzJ4tF2fE/kwvO3XZ3ajrUw0c+W3nF6zu0sKbQNaxSsh5ft2kKBcCFm/A1CbeEwigMM8uunl8G9uUMc1lwS2jDyEtHZJtMAWjG4vPWPzmntMklKY3LTKrIxSMXDxJ0p8G4HUuoV7mGoRPcEW4WNMiXlTJijysc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TWUAGtMq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hau5J5gn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TWUAGtMq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hau5J5gn"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CKH7BX1410273
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 20:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZdFCLTngGpWA30C2bWFo2s/6
	cKEcVqUVdYFFi/jmxbU=; b=TWUAGtMqQAj6Fi7WhbqJCAusyvFOT1ynlnnaE9Dw
	VeEvA1rUFb/TfKmQ4JocbrGAaEyy6/Bp4Qq09zDT5vrvgvB6TkmOy6TrVohe3OAb
	D3Vsolaqh4oVBl+qW8Jd4+pWRYZKQ0TojpbVCTuTcngVgDBS2d1AicSjQe9BlkIk
	RbbJ/7e0uRnQSdIImNbuO41+LQyKuPcvgnExpIOzXEYyrQmphXopYQHTizeUHtRK
	3dbuSbzI1tT2pLIHa5AzU7PNYWypUeZZtrptOE7rOucqqRxJ9c3GIPMaNDBT+uiH
	1e4sZP0FtL6n0EZ4lQVVa1byvCvv2Jbj2BcGq9nIW3kU2Q==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e44f31r8p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 20:28:38 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-132d5ad9c32so15214089c88.0
        for <iommu@lists.linux.dev>; Tue, 12 May 2026 13:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778617717; x=1779222517; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdFCLTngGpWA30C2bWFo2s/6cKEcVqUVdYFFi/jmxbU=;
        b=Hau5J5gnEOOJMy+yD6dBHvgdzE/BZ58ibIDeDXp0+FNdJ6qYrAAtNixcT0zWa6c6A7
         dOkv+++kedUhyXncK/gCEgcBZ6Prt9nyfSx0/VgS+yaEQCoLsv1Vpak4YskTqxCJPNli
         NuJPNGIwJKQsap6HSBuFiFhw+gnfCgluD9OYprdxvNTkOsvMSRtdjlhk4UcuGNsNTJlf
         PCbZ4YdfoYJ5ak6bK21bhtQS7m07M64UPnSsUNaod8lclkRDmIpjXxl2VeF4w0XMZuUr
         c7NfQpmmeHjCak2vpDli5ulaOOx/1AB/5Tgsr3kfkimaf/ybtsfQ/6Rh+FOsRQGNy91o
         Qdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778617717; x=1779222517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdFCLTngGpWA30C2bWFo2s/6cKEcVqUVdYFFi/jmxbU=;
        b=GarJFUDsPrvhEkFypivFWyIe6VeCUa+KxbhUSfPVrPebo5megXNkgKZMhz7Qld50+3
         ccapNo9TWFR4wvmw1N6jr1AB3BSATk3O6yyyvAO7OR6X41rf1vwnlWDscjYpy/tzPxaY
         SjK067hzqryeQIQzMZ/TbBfAs3g3J1NoK8MV2zsPI2FhZvxW4yRG6mlflqeniDTXj1yi
         JhmMJR2Te6KRvTBpDsxpkN9BgG9cJwoM3XFwv8vUmJlbbW4g47751o1bLy9Ar6Skn0HK
         a6/sD7MzLgRXVPwaS+iIgmZJkl+U+aJ8feKnuPwAu1htjztUT4uxgrOBf7un+wd1KCoG
         +upQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Ef3/6GAX85LHvZV/mCRhW2gVdLNYqPc5KYbPpMf8bO//d644TTxixD3zRxPpBV1kWjJ2SKA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yys5Boq9cPIaA1b10BdN8BPNkWAaOK2b58UbjkVR17Q3A5P4R/H
	nbmyaz+qlUlWyZBI4F204LZqeHlTyPYmWMCWtNh9ZiNNL+UmVccOOD24TP7IUgVhJrOhCzNoiCX
	UJfth322A5XsgsFCxvhtzmmaDya1oj5htx8SsZrdY6StT2KHakn5MNsE8rg==
X-Gm-Gg: Acq92OHNMly7IgzMXmYKUqDfsP5IM0zbUVA6KnMi4TdANKDlwugS18vZ6Q9AeoEF0Hn
	/FPut9p+gze7dFdl4lsfC5pYqHkB9gP1M4jaq8JSbrFCoLWt0pOz9sKdkdONSIPoqiue4U2dUPR
	X9K6z3JFwyHdVehJ3KGm7zyoUOdPBr0BbJ3Z2oL1C9GKm/zX1ieKllMs8CQyTEVANLcY3STIZfm
	kZUl9ux/MwH0zViSkwyJ7GoSdSck/8t7cQXqJhhcVicQERO4d+e+VgDO5eVOBe3EMc1vGPuORQI
	+aKOq0e2EI8xy4tU+mP6BeqoaJmPhsjH/IZTCYaIQRlTZnoNPAXsHl9k0g3Z6+pEp9k1oQ9A6bk
	eJrZ20DCvXv7X2Bec5VfNjAhw0i/ySwo=
X-Received: by 2002:a05:7022:e27:b0:128:dedf:f56d with SMTP id a92af1059eb24-134369a04f0mr278956c88.24.1778617717449;
        Tue, 12 May 2026 13:28:37 -0700 (PDT)
X-Received: by 2002:a05:7022:e27:b0:128:dedf:f56d with SMTP id a92af1059eb24-134369a04f0mr278930c88.24.1778617716854;
        Tue, 12 May 2026 13:28:36 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327865700asm20416753c88.9.2026.05.12.13.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 13:28:36 -0700 (PDT)
Date: Tue, 12 May 2026 15:28:34 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>, jgg@nvidia.com
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, joro@8bytes.org, will@kernel.org,
        pjw@kernel.org, palmer@dabbelt.com, anup@brainfault.org
Subject: Re: [PATCH 1/2] iommu/riscv: Map IMSIC addresses for paging domains
Message-ID: <ldiup5n5iglz6pabfup6hpvyi7543wmqu2bhtzxzysia7msg3u@tgp7adxloyy4>
References: <20260508212339.381933-1-andrew.jones@oss.qualcomm.com>
 <20260508212339.381933-2-andrew.jones@oss.qualcomm.com>
 <CAH2o1u4kUFyJqzRVOH4W0NxC0znabvi4V8VTQsURgBDErC8hTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2o1u4kUFyJqzRVOH4W0NxC0znabvi4V8VTQsURgBDErC8hTw@mail.gmail.com>
X-Proofpoint-ORIG-GUID: AP-CnLdrGWSKyLlIe7C-3FGQRdsBZIcJ
X-Authority-Analysis: v=2.4 cv=SpSgLvO0 c=1 sm=1 tr=0 ts=6a038d76 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=aZ6Tqwf-Lbvtu0Vc3D4A:9 a=CjuIK1q_8ugA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIxMCBTYWx0ZWRfX+LVvS7YnnIkM
 pkI5QlZrKA6vwTzKPHHLmPe+MYzpVWVn4IMwwEjl/MZH7oc4JWulJvOOLVXVFCWa6ilybIQ+Nuj
 DdsxuRcr6Q8u/19EX8t6fvfOzPOVCrC/pKE388/FWoxzumnhZZTYfrKY0Z6mcXk39Kq9A2adt+V
 BqSOBI2uBSycvn2RbCOs7/2JIDoMWbFB+rWytUljU4sa4m4s5oMOXjOvWD/UCyKDUEpyizapsGa
 jUAhXN99UfDw2JW46wSu9TJPQ5yIK//CLbCOMdRaNTd4SFz7GaI2NdIaMWT7BfQKoEYGpG6IzXs
 dr+DiIYK1xhqr9EyTkqTHinoMzjelK2b5sNGV+tNClpstbEQzARrLLSxx/50ndDYROi/f+ZhIyE
 COZtpmGDRN8fJbegutaBqEMh7U3gYDQSSsxiNij8m8kGRDR4MzSQZ0MUeKTrwgrKva+REcuTp2k
 Gbu1h5ikVOEGGl6eRzA==
X-Proofpoint-GUID: AP-CnLdrGWSKyLlIe7C-3FGQRdsBZIcJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120210

On Tue, May 12, 2026 at 10:21:22AM -0700, Tomasz Jeznach wrote:
...
> I would prefer to use the iommu_dma_prepare_msi() path, as Jason
> suggested, or implement complete IRQ remapping for RISC-V IOMMU.
>

I'll drop get_resv and bring in the irqdomain which uses
iommu_dma_prepare_msi() in alloc-irqs. It'll even be a better first
step for irqbypass since the irqdomain will finally also be present.

Thanks,
drew

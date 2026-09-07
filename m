Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE733FE344
	for <iommu@lists.linux.dev>; Mon,  7 Sep 2026 06:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763649; cv=pass; b=JL2VCWa3ocVeS6U/jsuBZd1lDLfGsEkv8TH0zFhK4H7gZBIwnghxTpwbv87WgkFk60KMXqm/8Cmt8ud623oVVUz3OtorHHxDLRO4um3we+NslneJDskNcDLolq9dhqhhxzoRnyqMs4LIDiOGn4NKBbUmSg8ZK/LLKolGv4CseA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763649; c=relaxed/simple;
	bh=FxnZj0MckH6pqO03f9x509TWv23X5RWV0FWZ6T1/L6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhj2IiwMjvjSWYsuFtuSrMC798OSENE6zLj49wHNhy0MKq5Mfadg8LrHChTRZpWkY/BLuUP0VZmraIk4lLsmIBMfkAfV0VqHwxXlRhUsNxd1BumkoXRuei7BHrqoAYXIeQM0gfc3AvBUFq3migqXlaxFh5y3d6dn1ZWlCB6ZjJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b=D7mbZRr1; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b="D7mbZRr1"
ARC-Seal: i=1; a=rsa-sha256; t=1788763644; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aZ97YRv/Tvn/fx6ptnwBseQZrGtZPWQ6tXniPU8lMMT1mdJqIOi/sTtN1+LDBxRdioOtw6AtMf1UnS4SmdOAMAREdbhsbtTkSSgQqu/lBigtRjR3zeanhFpb+T0Lh41pveRXPIeKlLXaZDkvse2YMm4zx9+gAsMTUhrVKbYYYfo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788763644; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MZ76iNv2wsLn6FzvQm1UHVo55YpiH7xVJWn0qNsNplk=; 
	b=MI9CPFXgY36tDkrR/4B3r2udr0HJ4cUn8WN+kWKGdjgRdCg55G1lTm//UPU0yi9S/0kazk6e1UDx8fihh3lyqNG6RObKaT71ZiNVLnSDpxqerxsZscprsA7XFnPudMLw0vLdUles2Em7u+mBZOFtBAaZUwGXSKf8xQpT3FOcI7Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788763644;
	s=zohomail; d=collabora.com; i=benjamin.gaignard@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=MZ76iNv2wsLn6FzvQm1UHVo55YpiH7xVJWn0qNsNplk=;
	b=D7mbZRr1AsonbCJg7gn2H5MrcgtxhGyG7O2yWnFF6HZnIOrbEDp9+b+B27tU/1yr
	/nMmsH5nsh6lpefplnK0dVyqEbsQE614tGVb0S6kLK8xSdJH/dm+ovWjUBw420WDVi8
	yovcQ8t+N3iCXw+UClte8kWA3VINGBvQ6YZhWNCQ=
Received: by mx.zohomail.com with SMTPS id 1788763643315606.1997041439481;
	Sun, 6 Sep 2026 23:47:23 -0700 (PDT)
Message-ID: <657051de-4b7c-44d5-971b-f2f17aefa816@collabora.com>
Date: Mon, 7 Sep 2026 08:47:19 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Drop the nonexistent vsi-iommu.h file entry
To: Daasaradhi Mannava <daasaradhimannava@gmail.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260905154900.1272-1-daasaradhimannava@gmail.com>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20260905154900.1272-1-daasaradhimannava@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 05/09/2026 à 17:49, Daasaradhi Mannava a écrit :
> Commit 917ace84b770 ("iommu: Add verisilicon IOMMU driver") added the
> VERISILICON IOMMU DRIVER section, including a file entry for
> include/linux/vsi-iommu.h. That header is not present in the tree and
> no file includes it; the driver in drivers/iommu/vsi-iommu.c is
> self-contained.
>
> scripts/get_maintainer.pl --self-test=patterns reports the pattern as
> matching no file.
>
> Drop the stale entry so the section only lists files that exist.
>
> Assisted-by: LLM
> Signed-off-by: Daasaradhi Mannava <daasaradhimannava@gmail.com>

Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9fb50c3ca..95b5a3bc3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -28608,7 +28608,6 @@ L:	iommu@lists.linux.dev
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
>   F:	drivers/iommu/vsi-iommu.c
> -F:	include/linux/vsi-iommu.h
>   
>   VF610 NAND DRIVER
>   M:	Stefan Agner <stefan@agner.ch>

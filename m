Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C165A274B42
	for <iommu@lists.linux.dev>; Sat, 10 Jan 2026 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768038555; cv=none; b=lte73BjZZ947mBIDqygOsjlDI7HPkItpe6dmUHngVvf10fk0WjKR7PDTU2t6ZFGAkIv/hKuoNu1H35zMBJgIrPErDKtIBvpowQlfR1zJf/YtYFBV9+mchSFXd2M8JicHFZztdqhUcQQ+svCZJXXGuLC2zY1rzMJTVVrYVe7a9b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768038555; c=relaxed/simple;
	bh=/Iy3VUYeaH62IFTViYJJ6TIHaZP2aNV1qPorF3/BWPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSEprqVd6F7Da/GAhmqMUjVm8wuATPsQ34NFQiRHwU5eEuBgjx3siQ2nI0F3O/IO8qfNxNWwIKaxDmsmy+W7V8oCi+fMAoqFb4uy/+3blcH049oWXDZJIo8UcxDqzVskyNXtJH+3Pg4clnUQ9EF4hwBSUPLvTBOEwV+XjOj4bOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=kwTHXANR; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="kwTHXANR"
Received: from 8bytes.org (p200300f6af1d9600dfc71246d978d903.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:dfc7:1246:d978:d903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id C9A1A5ED0B;
	Sat, 10 Jan 2026 10:49:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1768038552;
	bh=/Iy3VUYeaH62IFTViYJJ6TIHaZP2aNV1qPorF3/BWPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kwTHXANRz0u3dEoYirmwsEjwqfdBlevnQrs9dNXVADIJlRkQ5PQTaY8DOkgDaxp4j
	 vPzmHtEsi4KGx0WAQLV5RKe+p0NZI87m7syVqRkM/0hQfGRAD38PW4RH831g3fVSBD
	 c/NoYFafB/xgS07EYKnMRy7HSNugAzQTYk3UViXgFdLj5g2icp4ZP840TnyQ8r6GWm
	 pz3L3iU4S1VAuwWW4i0tg8DvgNFwvICZ/96XE87O2cgBL/w0krIOBiajh53TvC2z1d
	 /mY9kyeXW+mZthHHkcYBEPbAl4/I0zjxF1tA58dRdhWIUQO8Z2fA08n4dER1oCKbxF
	 4j6pBn5rNrkMQ==
Date: Sat, 10 Jan 2026 10:49:11 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	robin.murphy@arm.com, will@kernel.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH] iommu/amd: define 'amd_ivhd_dev_flags_list' in header
Message-ID: <5cofja3paenv6sr6vyy6uvtvveug6snws4q26py7fhn2kdlfjs@26amjux24irc>
References: <20260108102541.232459-1-ben.dooks@codethink.co.uk>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108102541.232459-1-ben.dooks@codethink.co.uk>

On Thu, Jan 08, 2026 at 10:25:41AM +0000, Ben Dooks wrote:
> The 'amd_ivhd_dev_flags_list' is used in the amd_iommu_types.h
> header but not defined, so add the definition to remove the
> following sparse warning:

I think it is better to just move the for_each_ivhd_dte_flags macro over to
init.c. There is no need for this list to be visible across the entire driver.

-Joerg

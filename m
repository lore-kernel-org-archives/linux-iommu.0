Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3ABA4C3C3;
	Thu, 27 Jun 2024 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719483347; cv=none; b=otAK6O2d/wcaks/D4DJEDlZdc1eMI1POZTB9oFxYuAztuSExYz52ppr+3xUSv+vDYfdCf6Ju0A5ZeQ+VAHWTTC682PYHCe8KAMOLxy7JuvkdnD5APmsa0u4v8Z9NJVbBOcsg1wAN5d3v09ZNJdKDaYec41gRmjsl5z+dp1wTF0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719483347; c=relaxed/simple;
	bh=ZF4PApED5GTf9Xbzl2eZmf+j4NHifHmVjrxijxTcJVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKVOkYwbmpAxGy/Wg2cgMcnZ8bT7tYA2lWf2b1Nbo3a27hMzDY0zdA3+nKrn7ImO28x6pPXJT6V9TJF+rdK+tSXWl1Ubzr0467x5M6TEYJz2OnxRUKa15euSl4D9WcgXM0TGdE5IhGuE+W7Uh3f7F9CefJhmyMukKOQdMTl8kBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=IAGwf+++; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="IAGwf+++"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 780C11C89A2;
	Thu, 27 Jun 2024 12:15:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1719483344;
	bh=ZF4PApED5GTf9Xbzl2eZmf+j4NHifHmVjrxijxTcJVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IAGwf+++n1ZgBtzeUMLgc+71IL4SER0tgkoElxgJV70inzhUqeiI2MOQN/Ay2/tas
	 qJb05tuYRPtbhysJm9bFZJTb0prPGMNyLXIG594xIOhQYXq9GoOeEE70YdmjXOwwxK
	 YfqHL/2+voHSPHMDnvpnNQfCqEwVpEiDslxzoytz5aKhT00pp53Q93UZJUkADwWzpu
	 4X+aB4pe3/4oddIxjymHxFgIMvJf2UKfETRV5GvhzDTq0b/AxzM/+OgiZ+yx4bBKf1
	 mprsFC4Au+PMcr/sh37E/4W3pjLq4vs4Qe1eH9F9Wcfvk2j7XqrBCHjb4FApLaMZgG
	 A1qg05AwCtIAQ==
Date: Thu, 27 Jun 2024 12:15:43 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Ryan Walklin <ryan@testtoast.com>,
	Philippe Simons <simons.philippe@gmail.com>, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/5] iommu: sun50i: Add Allwinner H616 support
Message-ID: <Zn07z2dxhXNmM2nx@8bytes.org>
References: <20240616224056.29159-1-andre.przywara@arm.com>
 <ZnqyDLMzND_qJiOl@8bytes.org>
 <CAGb2v64M_trcaXzef6=rbWZY-r_sv=bvoHngUeDVWjx+AXTy7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGb2v64M_trcaXzef6=rbWZY-r_sv=bvoHngUeDVWjx+AXTy7g@mail.gmail.com>

On Wed, Jun 26, 2024 at 12:20:08AM +0800, Chen-Yu Tsai wrote:
> Could you back out the last patch? I'd like to take it through the sunxi
> tree, which already has other H616 device tree patches.

Done. Removed "arm64: dts: allwinner: h616: add IOMMU node" from the
IOMMU tree.

Regards,

	Joerg

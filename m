Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5077E20EB
	for <iommu@lists.linux.dev>; Sat,  5 Jul 2025 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751740710; cv=none; b=TADEP5nyZ98RpPMssWitweY10xxuoiFfgAWaR5M3Bk+7YvICP3nsJEszuaE+YOQipY3yYSVwUYXtk+TTEMCXmTTQuc7tAalZZz8iSX4LJ02Ms3PJhqJIn0R928NKdR5MQpFNtc88aMdwsjCoSzXvOFuHSK54mR/GpJi8OC/PDSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751740710; c=relaxed/simple;
	bh=WIHdEgEb4h7ncGmlqKNUeHDxe1TLcrT5/vC0Zduw6NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMXLi4yNIh7ZGrPTpxgwQUGbnMsgF5FY2LLZfDcEAKfohNWkTJ3elpCI9HKbu2BeThB4NtpyiaivMjPfBtthqnxohwfLjOBP9YbsO539XHi4V9KT/0wOH42sEYIBmaooQp3arsHfgvsMjiAqfO+v3KefEQMKufEPdpEIPmfHbUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CnQ1V8o3; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CnQ1V8o3"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c5b8d13f73so195149885a.0
        for <iommu@lists.linux.dev>; Sat, 05 Jul 2025 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1751740708; x=1752345508; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WIHdEgEb4h7ncGmlqKNUeHDxe1TLcrT5/vC0Zduw6NY=;
        b=CnQ1V8o3ixFzzl/7cSW8v8WZwLWe/kRl/58sxQcjwC/CFqzTHusV5otzw0MjEUfIqs
         2B9OhaM71mtKhjbwJ6LzCY6pXUKg3bZbsM/UW1IeY2qeouo14Sfg6m4rn4SBR99ZFWMR
         rpji2CpwjgjMbvAFwLWwvrKcLR6pmqU1SoWAYOtIoO9niEmY8YxBqNHUTLYho4B25oVz
         Ke18ejgtyBsXekGyhL/hECYslECPDnKYhC4MCZlDVj52t8ZhlmWnSMVebvTIOLmCPrad
         GFAZKC4rG2RlmcggYxyNqyhxJXkj65Q8+bwMTKC3mwUg03enb6D2RD2GKn6occFw+8K9
         jCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751740708; x=1752345508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIHdEgEb4h7ncGmlqKNUeHDxe1TLcrT5/vC0Zduw6NY=;
        b=C5qW71LWGkYDtWfKrFtFVQ96vJWO2OY1mjHHTMElmMTOxAKUrqgr8tipzbIuvqAYy9
         Cc1QQmOUdn68E+5hzkc+ZR+d65dxH+iEKwK0httStV8GwBIeUKi2E3l/Mb8Iv6wd6wec
         mf9X9V9iWKcDW2kyvbA3h00WtyVlBRIfZhHnnqww9Za2FyabCFrzgQGAuaaHiOqstwBU
         qEQEBIrcKqjYYSPXlOArSey67xMOeiRpqeII0fIdAX8myaozONyCbTjR6uPYQzUZFDbo
         ZKWj9SSB7lSBcAPHuUVal5IxILsMCtUhgG5eJ5hJ0RFTSiN3MJOBUNYb45DdK+0JoWpi
         BlGg==
X-Forwarded-Encrypted: i=1; AJvYcCU6qYzN1ImmjhcnuWjgCmFI+FJ6sJ9yOBM11E3vE1T1hZsU+zuv+VkjFN7TJv3GLXm1+HG9xw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSYLOShEfj91xJ2HrHapfuO29SZZ/pqPkh5u8OInfB7KDFhIN3
	piNt9p5vxnTsQnTPcle3CN1Ut5qNjy3IpqUyxBvjdj55Vb+icrsQkrAWa85ECQ5KWFU=
X-Gm-Gg: ASbGncugTWX5cJ/ne+X6GDH6IggjjxXUKHIqZt70yEl0E0Yknb705nwLqY7Y5S+EXEi
	vrxkIJJ1Nd61QltOFVB203nbs5TSxr6htXBjRKDeBQ9/XNLW6Y4Ggw4EbrLh6egFbByHu2cBpHs
	amTlD/1UouOCl0OQxUcSPJhtZ1InCoKcy4qMaL6sONqLrDlbtXVuC/WM2txQ8yG/HXd6yo5MzKX
	6BhLdGUA3D8+yU5bdBVP222R4r805iMyc59EePBkzCPv5Tz2inPmGQ+l36/SnrKubG/vcCZFGMb
	jRiQZIdiD9h6GYinoXYcfwsoRLXMm83aF7HxR8hiUZ4V5dyp0A+951uI/xLkoLfj/pM/lvh7A6m
	xyGaUcUKOGxpDxbwuPpaJW5qhwDhUeeIC/VvYyeeh1ymeXkwe
X-Google-Smtp-Source: AGHT+IHGynn880Btao0rr5ATgmcaLhy8fafgWIOLP+yaNkVftZqqbIrm82pa3BfiHgQu8aK3kR04IA==
X-Received: by 2002:a05:620a:40c9:b0:7d3:f0a3:d8cc with SMTP id af79cd13be357-7d5df169b32mr814175485a.45.1751740708064;
        Sat, 05 Jul 2025 11:38:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbe7baedsm345886685a.57.2025.07.05.11.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 11:38:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uY7mM-000000068pv-2jB7;
	Sat, 05 Jul 2025 15:38:26 -0300
Date: Sat, 5 Jul 2025 15:38:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	nicolas.dufresne@collabora.com, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v4 3/5] iommu: Add verisilicon IOMMU driver
Message-ID: <20250705183826.GN904431@ziepe.ca>
References: <20250623153931.158765-1-benjamin.gaignard@collabora.com>
 <20250623153931.158765-4-benjamin.gaignard@collabora.com>
 <20250704175425.GM904431@ziepe.ca>
 <62cead85-2d50-45f1-8020-7aea77f6833b@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62cead85-2d50-45f1-8020-7aea77f6833b@collabora.com>

On Sat, Jul 05, 2025 at 12:04:05PM +0200, Benjamin Gaignard wrote:

> I would like to avoid that but maybe a static spinlock can solve that problem ?

I think you can't really (technically) store an iommu pointer in a
domain and not prevent it from being used by other iommus.

Can't the spinlock be in the domain?

Jason

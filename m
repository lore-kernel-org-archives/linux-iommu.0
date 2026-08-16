Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB7538DC6E
	for <iommu@lists.linux.dev>; Sun, 16 Aug 2026 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786899452; cv=none; b=ANvZTJVf4UtwHfXZfkqKiWN/f10tumQpzm38Azt0WSszeKhByoclotUyMzDV1wTthMfN9YuDeMBE6LsoYG5hpkVDEaY+Zp5Mq13krsuWJSiySQFQvXGEFHaK4Id3K7eP73rFoO1c423J7jaM7NoR0YW7zciAqpIxP95d3c4Gtko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786899452; c=relaxed/simple;
	bh=5vHK21ZfMoXP6dWuV4jOPFkA3UZYyqzqjngLtc/WPvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p25IYBG7u8IHvogF3uK8EkmwyBk1m3brEgPFC/7+kB3wqb25Lg1oKUbGqZoGoBNQDodytkUVL959R8GqI4Yk+OG5GzIE3qUadC39HPWQ0idYoXue1IiFGTmQujJHVTKtP2trG09ZRCEOYyxQRD4XusfILyTqGMuxF/Qwya/FZ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=i0h/bcKV; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="i0h/bcKV"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e5c92c389so129489785a.3
        for <iommu@lists.linux.dev>; Sun, 16 Aug 2026 09:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786899450; x=1787504250; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5vHK21ZfMoXP6dWuV4jOPFkA3UZYyqzqjngLtc/WPvI=;
        b=i0h/bcKVYA1PqdZ7hREVUo9da5pSnuXAssEa8EYcawFiuUtKuZkyHpVf5mmnWrOaNs
         DPDCpIcli441sZ8JxcF/Smi7My64SSYTQ76n5uc9zs34rjF1ftHxw0FKqqLGYT22M66j
         tNlLOolcUcisgaqPDJozmqURy4Csd99P0w0RNJDz0xVUjUsqgMQM67Kao+yvF2iLs1My
         onfT1E0HS49kwu9fih6K7vMLmEc55VpxqcDMv01pKh9yFN5LfYV2+uNrdukkaIuXt8I8
         M/KrYQ34rMQutw9jBmKMn6ZvNs9Sq7sK1T+0CruGsk/1ZuGPJFfQwALVZ9MVwqrg4i+i
         N/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786899450; x=1787504250;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5vHK21ZfMoXP6dWuV4jOPFkA3UZYyqzqjngLtc/WPvI=;
        b=rGRP+y3iGZhmMSDL2kRAkqf6uJV0vuoyrLtI1jxiHrkOGTourKY0I4ePF8MXkf8lLA
         Irn+eapEsvKQ01Lre3flfXvo0cW1CvnR0v4O+FMMbAG2SihkK0QGR6RaZByC11mlPhWh
         Ti2n5eCA8qgbr4Pjy8KHlPY/Y0NJz5ElrzgLjazELmkDUSXdTxgKbX6i33M8I1eU/Ge9
         /nPeFqs/KDg0Oh3SaEO09GqeKZYgA8wfPUdsO1m9VZha2c/CXsJmG89U8K0SB+lGAPB3
         m1wByslJv/VJfa//Ts+WkaPHwf4lFYtdDwaCSAq99bpZjIuuTIymqfRLc2FgCsAJh/WL
         9uGQ==
X-Forwarded-Encrypted: i=1; AHgh+RrRk/6DhBVmoz+9r4olYxQsBH+xb+4eB6AZXGFYnQnhdIWwJHL3eCnRAdSkloeQPN2KhJ+A1g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKifkacUSsxEq+EUsCc5bpLtRJ+wz0aJoAs6HRNL+NcXdaKHgj
	+eaiqEOKrCiW+Wt7gnCIy0yUgBp1iVQFurDwehe0CdTfbJaUwG0VRX+WHObqDPrdtCE=
X-Gm-Gg: AR+sD13b+l/HDCvjbixBT8wyHkm0zkBw9Lx/i/ovJYHaAlyakKh8feoAnbw4YIbzD3e
	UkbUb3erYlW6stPpTt8k2eHLrBcXrFIdOhca3biI0D1/n/CWNYJYR0vr9nuGoRTiJpQA+QrsJkq
	SM04ne9hQrW3m3gSGgsJV+Sv8hkaTFVe/7LF6NOYnGp45TajSO3SV2x44iibgpuLHeN8wHiKanA
	Dd5irfGQc8pTm5ScuYQfbbosu5v+CTk7Go3N6WtZw0gUmDIKU5v/rdb8Rty/wMh023YNW5qIzEl
	d4x14hCG2i66FAm1t9E8UU01vfLN+2sLEsxqaUnVMWoKB/VMdzTE1JxrGbfehn6xMkhqovmSRRH
	zjpnbF2l7sZOJ73WABSt5OAcgDMZgqWQg+uVmerID9V0fAehp+rEzKpRwP7YA04bKABG0MfXbxh
	Ej8VywffMCxu5qyBSKuFggmNDrhHv3RHktj4m6egi1/NCFJQx8
X-Received: by 2002:a05:620a:4089:b0:936:e08b:733d with SMTP id af79cd13be357-936e08b78d9mr1435615185a.35.1786899450058;
        Sun, 16 Aug 2026 09:57:30 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce0898efsm784134485a.12.2026.08.16.09.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 09:57:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wveAq-00000005W02-2MZ2;
	Sun, 16 Aug 2026 13:57:28 -0300
Date: Sun, 16 Aug 2026 13:57:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Drake <dan@reactivated.net>
Cc: Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	nick.hollinghurst@raspberrypi.com
Subject: Re: [PATCH v2 4/5] iommu: Add Broadcom BCM2712 IOMMU driver
Message-ID: <20260816165728.GB933791@ziepe.ca>
References: <20260727-bcm2712-iommu-submit-v2-0-0247b5c03de8@reactivated.net>
 <20260727-bcm2712-iommu-submit-v2-4-0247b5c03de8@reactivated.net>
 <3e7ba95b-51e7-48e4-aea5-f86db1739ac2@arm.com>
 <amlE8rEgryPqrUZd@ziepe.ca>
 <d6bb859e-c1e7-428e-b765-7b471e1ce005@reactivated.net>
 <abc25cfd-0c7d-4719-b6af-9034c87e9f88@reactivated.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abc25cfd-0c7d-4719-b6af-9034c87e9f88@reactivated.net>

On Sun, Aug 16, 2026 at 01:50:32PM +0100, Daniel Drake wrote:

> Let me know if anything sounds off!

It sounds reasonable to me, and at least from this starting point you
could imaging trying to build a scheme where individual devices in the
group can use the group wide paging or identity translation.

I'm not sure how that could look, but at least from a DT and driver
perspective it is not such a big leap.

There are several unrelated topics going on where it does seem we are
not giving enough control to the end driver about how translations
work when the core happens to bundle streams all together into one
group or even one device. So maybe there is some merit in coming up
with a way to have multiple translations active within a group to
greater expose what the HW can actually do.

Jason

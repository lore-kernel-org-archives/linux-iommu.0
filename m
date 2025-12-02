Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C421E2206B1
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764702939; cv=none; b=MWz0MuAFHfqwqsWq80VNexPMBpQwk7b644CqmZciMfUd2fuV6l52dlpbh/zYgFOvqUdcCRF/SD+XAQbd7tdkcUIuHI3D3sIEOYAT0ORGmkNIhdG58XNaRthDJ2L8dYbemPq6Tu9UMh/T8Y4CTs4soNUNsq74xSSNRL+67/0iV7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764702939; c=relaxed/simple;
	bh=02VswylmaKTEELLi7Y6w3IpRRDcUxofhyMHg2wDIGqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJkN7Om9B5tZ6NQKntgZON+L4lO0dxXvyxqJFFbBfDKHZrgcJUH9oiiPiecHyOfCgsy2pbmD3QiyN/mcjW17oLTk/Xa2YOddghJus+ZxwMgzmnOBgdU50sxHeoiemXHVAV/zR9Sk4cG74Wxbbmou2wg04htriNEv2+UPnyTyf24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=D0TP7AQh; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="D0TP7AQh"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8845498be17so73777296d6.3
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 11:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1764702936; x=1765307736; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYXufk/CghCmeROphf028hCDLM+wcJfUx/di8AGxJis=;
        b=D0TP7AQhrvJeaYo0+rRCCLbndJA3bFbVIDdDSG1zqxsrSpktOaXu/uCVh3Q1ltDIJM
         ckV+EX6iSRcQ79FZkS6SuvCMrT5x/4wFG1W0i6ATDO7wRRNMRRhie5NtdUZmVbZHkrma
         XzVH0XJYjlggrHna5Ph7ItZx4nYnGwAiRjpHJGMGzPxkv4IxOc7VqxolrWwKZor+EWAH
         n7yaTLAkukANXmaknfYfMKHuuw4VoYRZNH0AXzNRnPw95eK+0/zWwEJffAxBkc+kbANk
         CgSOZnEb0M5NCzX9BTkG8VcV4CnSs+PrQ1Ycm4kyEdJK+QPUWalJM5dLJfII5+ZfTQLA
         76/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764702936; x=1765307736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYXufk/CghCmeROphf028hCDLM+wcJfUx/di8AGxJis=;
        b=R1+Dk8+VTwGrgum2TNQwtL113CE4LOrZZ0oKtuphprthDlTsM9gRLKelW8jmT3vbYv
         o2sM/qwkxvqQ/y0tsyV4QBOQwi6mZlEz2Va7P076nlHQYAuzcex9WvWcpqjRZGj3tqBA
         CkyLMBu7mhdzESw3jttjz5pxi8JjT1y6K/JQbGK+FzpRvL33DcEi/0tw2PL3WFRpl4uy
         JFJOjvb1UT5sME9Y1zSQ5R979XeG7JtbMVEVozILmyYDmWCw4Owf0a6140wtkQsw5eoR
         26NH9nUGaa+NeiZ3gV3Dvgr7mMS8drMP1nzhvpM+KTJ51g+MBj6xqOzfCUNxLMCtF95N
         N1+g==
X-Forwarded-Encrypted: i=1; AJvYcCXv8kamRP9I9RHYN24rAmN1gTOwkq07qJZZZlWXfq4qr+FvdoW31KW9E9ZpoEY2/KrwBc0I2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwrwIpwowQ3xRysGuhneCjZsVZ/3DKjH11vaYgcmEH91mxsIZAa
	ue1Ue/tU/OIluKKx5ZBicpazeHLezBuTfK3sG3pcq+OVIWP3PqJLHE0yWUTRFQlNwLY=
X-Gm-Gg: ASbGncuGks0zM7DlNzFt1YUvA9Ycdw3t6bjLOcSO8kjxSSqpa1b+YfYJegUv4u2ptGU
	4oxbX7WAG3C6FWyCVSg/zEMc0k4+qjn1OqTIJbUCc4oZLeRC8oJHwI3ki9ZDSzxCywpbtYLwU3c
	j7pwnk6nGJjHirKNS7x0bIV7x9sOGz7AeDHjnnhUlE25qAFdKzlkeUue2+VsdT1xXi9K27P3PH/
	KmAN1xkyb3W9g7KMseWpeOhFWNCwPt9FlDfFwurkG6vzd/h9lLEGlGa/dDdIG3lbx4AzJqQEdEJ
	GAxEYZy12Em+pe53YW+MuJ+MHolJ0c/EECxpn91U2ou2HDrq46JGwlLVSTQBe2vHGKDShPZPXyX
	QG7CbF7DhLsbHHWf84KrBKnjsTVOLFSm0HwNgaj3/87WiSTUK9r6H719Bwuzv75JGFotntkzicL
	r4o133b93CMgX/xo5S5qXAM0Umy58Pjsrd+jUcHH90GenxnU0iKxabQp39
X-Google-Smtp-Source: AGHT+IGmiowzXqNsrWumuA10yrxW+wsYpQdV9eVH0NfTUqUkzV4tZO5Fje3s2ud/cDX5d0jFbs8uxw==
X-Received: by 2002:a05:6214:23cb:b0:882:47e2:9cb1 with SMTP id 6a1803df08f44-888177d47f8mr7616446d6.43.1764702935239;
        Tue, 02 Dec 2025 11:15:35 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88652b91ba3sm110766546d6.53.2025.12.02.11.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 11:15:34 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vQVqX-00000004tAz-3gdk;
	Tue, 02 Dec 2025 15:15:33 -0400
Date: Tue, 2 Dec 2025 15:15:33 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
	Xingang Wang <wangxingang5@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v2 3/4] PCI: Disable ACS SV capability for the broken IDT
 switches
Message-ID: <20251202191533.GI812105@ziepe.ca>
References: <20251202-pci_acs-v2-0-5d2759a71489@oss.qualcomm.com>
 <20251202-pci_acs-v2-3-5d2759a71489@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202-pci_acs-v2-3-5d2759a71489@oss.qualcomm.com>

On Tue, Dec 02, 2025 at 07:52:50PM +0530, Manivannan Sadhasivam wrote:
> @@ -544,6 +544,7 @@ struct pci_dev {
>  #endif
>  	u16		acs_cap;	/* ACS Capability offset */
>  	u16		acs_capabilities; /* ACS Capabilities */
> +	u16		acs_broken_cap; /* Broken ACS Capabilities */

Why do we need this? Have the quirk function accep tthe
acs_capabilities from the register and return the value to program
into struct pci_dev ?

Jason

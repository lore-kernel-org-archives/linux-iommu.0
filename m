Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F922F39CE
	for <iommu@lists.linux.dev>; Mon,  2 Feb 2026 23:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770076013; cv=none; b=SQBCVs0F4lFOM/zJIC1/gJbUfUcGeNo2AmLzyrUxN51lCJD6pIyyWj4iDgKWJsqmmnxy+53aGdVp9fWKl42RtFg5/4vNMDxzDOfu8vf7XfyK8NzUxXFo4tRTqo36mtALOzv93Zi7kJvEdx55LrTp0gPt+UQzCBoOyuo/YuxxcRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770076013; c=relaxed/simple;
	bh=62IN2YKxH9XaFDIdC6vrdP6RQM/qyoN8Q3fcds1LozM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuztkiXskiw1GcmCMXCh2C6cPoB1huGiJPQT4+CC7WVcVMm8T0xv9jlhoJJB0x5kYLR6flK+t0D9uMWbPZOM/du4DARAkUAwDc1+hVMgx6reHoOIbHCQM8g+yHnFkGVLaEb2nYav2mugC72PCaQfhmaPnhDiGN05lPBV/plIlbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ozTYPb+Q; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ozTYPb+Q"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-501488a12cbso61698311cf.3
        for <iommu@lists.linux.dev>; Mon, 02 Feb 2026 15:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770076012; x=1770680812; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=62IN2YKxH9XaFDIdC6vrdP6RQM/qyoN8Q3fcds1LozM=;
        b=ozTYPb+Q2JCHoblsDbaXdMmIh/BNaFOwzGUNDCENJ5zLmbTfHG8Fz3W14xaBZ3lQVp
         Dky1cFTK/9Ln+2m64BQm3kUGJcokPU7HNCNzKgCvl6FRkrK+NiSw0xVB1aMFq1bZymrq
         BgArcouuwgloNz2Q1WGBa8hwwr0Po55T1g8LRjWYQcbv0M/I/n8zwqJwubkEkd6nKJg+
         Y/YUsaE0T8Hu0tnaCbym/5XmGx+h2MCGlFX02+lod6/VvkKuXQS7POUuCsVk5ViV6/ti
         4yza4C2HI0QXcK20F+LVtDkgwnJSgKXo4ZZnFOQxg++VKXIaYZogk8PgrWqGxEGB2A1y
         KpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770076012; x=1770680812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62IN2YKxH9XaFDIdC6vrdP6RQM/qyoN8Q3fcds1LozM=;
        b=I2huwwnlC2cRIaOiQ8j80wi1yFo8HfeRnyBTCf9aC0pc6tboiDNiZVIBJ6Vdz9La65
         hU/beluBqvz7M3QZ5JntAKRC6aBvomB8G00upeCT11BhYq45Zo2Hvs9ehcxqgAFvgb/s
         LDkqGzEUQWo/SXYg44i01lU4GmplozEmwWIjzg5Dbd/p7lxRWQncCNAC9nEdxDlNSOcb
         7+H9Rw/cDED67NvAYeA6GSbrmO0OfmcklJV01eEKpZI5XuSUPgd9OUOwwVaZZLvAr/kx
         lhvWZ+aMsWLp0xRvJOBs2l4tvUK1tRx27pYLshLLfTt5IlJOFP2b9UPg4L+sS1i9+LIX
         yQvg==
X-Forwarded-Encrypted: i=1; AJvYcCXHmOc33huEP7fD7CpcqJ4vYA6N/WxRawzjbguHjOKj+yOJjS5I5D9p3LOR6AaFZXr+LJlg1A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3dZg0QCejLZyaTSC/egMtWG83EsSb3+ZPYxOnegDLvH3vH5sS
	GCL4HNC1pjDoHdTjGWWbdjO0KeXQtDp5H4OKPIYD+7Ezj5zzueSZEUb9r7RDijzebsE=
X-Gm-Gg: AZuq6aI+R5IQ+LsHO/30AZSFDelt78uVzhur3kSPO1aUL8Z8oWWquYkk28o/bvs/GIy
	/rRNoyRSI4ELwTf5dCZn96JTG7fi3cxblV/515YE52CuHMZBpLxBIPiIpKBdIjhiqW/YGOiY2Yx
	1MFPoB7dtKwEGEwLJnKJtS7i5+ZmnvEm4jbe8Z8jYJosnGjPLlbT7vsXIpuwAQtjF/+KLMEs+w4
	psuko5b1gybu5QOcoNn0cdyfGcO9ha5xHJWaOyWdOvB7D02JLhLvhHs9Pid7s+TolLUgjzfwi+8
	poXeqjgWNLBWNXrFHhHmLGRgVPKXJf3PFkubod0fJ4Dw2SFCdnSv2ujt0BNE7EiX4bA28W0qdH6
	GAc3RPrEkCqlXZm0UWk4DKUx+O62Vw+h7DJLakyFYlMbAcNYNmPuy/zUNXEPH8H7KVkPtO49T3w
	Dbu1zUxSKvPgzdlVmDkGs7shM7SHABT7l95ZrPMiD4n52tywSFdmJQMtkR9D09hvyPJvc=
X-Received: by 2002:ac8:5f54:0:b0:502:f01d:1b43 with SMTP id d75a77b69052e-505d2182c88mr179747321cf.29.1770076011770;
        Mon, 02 Feb 2026 15:46:51 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d3740e62sm124545356d6.26.2026.02.02.15.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 15:46:51 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vn3d4-0000000GNsH-3dK8;
	Mon, 02 Feb 2026 19:46:50 -0400
Date: Mon, 2 Feb 2026 19:46:50 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Matlack <dmatlack@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, YiFei Zhu <zhuyifei@google.com>,
	Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH v2 00/32] Add live update state preservation
Message-ID: <20260202234650.GO2328995@ziepe.ca>
References: <20251202230303.1017519-1-skhawaja@google.com>
 <20260128195943.GY1641016@ziepe.ca>
 <CAAywjhRXwRD7rmZ2DjN2roDMvWCV2772KhM2hox5RE8Prt4nxw@mail.gmail.com>
 <aYEpHBYxlQxhXrwl@google.com>
 <CAAywjhQBS1xCSJeTK-X1ThbAfJ4zW3Kwe7me2Nwt3dmGCEfWEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAywjhQBS1xCSJeTK-X1ThbAfJ4zW3Kwe7me2Nwt3dmGCEfWEQ@mail.gmail.com>

On Mon, Feb 02, 2026 at 03:00:12PM -0800, Samiullah Khawaja wrote:

> Agreed. In that case, I can send a couple of extra patches with phase
> 1 to restore iommufd and discard the iommu domain on finish if it has
> no attachments.

I think restoring is the hardest part of all of this, you need lots of
iommu driver changes too, and we shouldn't have some weird uapi to
accomodate this inbetween state..

Jason

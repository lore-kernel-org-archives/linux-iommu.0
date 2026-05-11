Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623064A3412
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778525134; cv=none; b=e240o885qhNBGMoE/bUDbaYuSLqsTVBb7PMiqYuFKe5mdpL7OECejBxRhskiDptwDAYPHXDmrXU2Yo8dBiSkggbxXtM6YfVzviG5cBqUO9dCdQsaHuz441cOM6KfXvFnb+Q1vyKX3QhGDoO0bbY0GvsIt+2YWQkIkXxrs9avc3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778525134; c=relaxed/simple;
	bh=EfTIbAWmLDFDyvNFwjeqvGW6T6qTRBjvePBREiQPCEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7lq28CHuzO/XzEvzXCMwrRAHl+7O9dwULDW/Ee9YjKr0W46azm7DC6lDRd627hdfh7F8XhHiC+sqgrtmTZWPBxh4igAapHZml1fuPiE33+PPjNsnZzG596CI4U6PBurrgJ2kk/xA2f8beu7eB1qRdQ8vKNv6H7CNGHUKCsZeCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jsvOIUYO; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jsvOIUYO"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-132cccd3d77so1092c88.1
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 11:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778525131; x=1779129931; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P4ZVeg+YkmtR9q/2zoKbQ9G/S4IeJPqOrtHp4fCMixU=;
        b=jsvOIUYOZPl77Wad2dq/Lq4ohqofrDcp7yn5M2OlMK0FK9MOLzNqJFu29hDqh5Dvjv
         CQEupaqgdf9x4cmaacGHrHMQXWY4KMnGEC3lnButtqstc4jx3JRNdNB7FcxXJ37pD0yr
         QNC4FQEeW0VCx+N+lFcDQvLY6uex8j5pnZa9+KP2YbrpToNPn5PlrHcrCAPDWj3TJKQ7
         Nho2/MiFSmzQPNLDYR/3Mfe5jTIF+cy3zEC2k8SRuYdfyqZomaHrUsExuQRPVKqaj0PL
         dUEVmY5dNvGfh8HUEwhkVhoCH+QvfyCZb9IJqyNvtpLsAQzIIkyIgXOinVONCe0PL2YK
         BXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778525131; x=1779129931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4ZVeg+YkmtR9q/2zoKbQ9G/S4IeJPqOrtHp4fCMixU=;
        b=Bf/A7EXSOJwnXBSPhlQ6YGDK9wOs74Pz5/AEEA8vqzn/OsZttojwXoIuHjBW0pn+yq
         sm0Y4uT8Wpin1HFxqI9VCa4ZqrNRLsNcr9eznTsBrQ8OQ2SYNwgJVCPYFhuizsD7TD4o
         fHsgcnuCY0D3limKlxJXI4iHWe1WHNUsChiW3rATj2W83s9ZAePtfeJksS/k8JAnqijm
         76nPMtFZ0xaECADnVOK/92zD76JL1gQGBWE+Y1daw90GGSXeQK7b46BMQw0iRtJHa0O7
         B7OLtMqlzYd8Mjpj+n9fzTIXcUf6Ny8sBKJBKQVLivdqcwEum5zV3lsdWXIYTRUjk3iI
         pM3w==
X-Forwarded-Encrypted: i=1; AFNElJ8h3dJTN9JNZ/7q6lSSO2t4fdzx33TGiLimzdqDV+bwobNykMwGqsxgcbxTjZe+i7KmKde0Gw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhRit9BWY91e8QK2wkfswkQxnDadZXUg+CQauxdtJGZXlD9SxR
	hincisMrn1jgXQm9RlEAYlKhjdwKonMsPEE8eAjyBVjNhxsjFVhEdUc0Qxqu5MUeqQ==
X-Gm-Gg: Acq92OFWGMNq1LwCAMNU99g4pyiO8+L/zBBConCQF+U3VBPXLkI1Umf7zioO5fZ2+Wh
	vDGGIVbF8UF0Nvh731zqrKnJoLzmdECPBQo2ipNGp5GEJsGkgPrVoebzMjNpRGq8qZN5zRzUAhp
	B+fYoc5d8gcG02F8CeuGmsagWH6OTHI215ZB3GGnfBNBFPBuSJnzAHRXGfueJ9sgd3mCY4wY0La
	hL7uE4S2SVxIGqDuGwk+3YCehBLPO9AQabWfkP13ZKQBMaZQNGCOj0LDn2QBDkKmo3PIAwXTnuV
	GePbXEmiFPyKCYOXxwZgOOKadIGr6s6sP+PccziNGvZ22prD+nc2OMKSPSXIIPT2hZxsyz0Su63
	Lbs30riobE+8RIFbFZdkR0d3OK89yu5vCbVl1o/ZIlpJXCZFR9W7aB/As3IIrtGTz0OMuJYURD9
	hWj1vLVvA0RKlWJyjWPAQDTnEO8aRLqXDcPBAstm/9ptIef8j5Lo8xvOyd3FVyf7Z6q4MJDA==
X-Received: by 2002:a05:7022:b9c:b0:12a:77e6:68d9 with SMTP id a92af1059eb24-1333e4e41dcmr55502c88.16.1778525130642;
        Mon, 11 May 2026 11:45:30 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f91004b6a2sm13056216eec.0.2026.05.11.11.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:45:30 -0700 (PDT)
Date: Mon, 11 May 2026 18:45:26 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 11/16] iommu/vt-d: preserve PASID table of preserved
 device
Message-ID: <agIGEyL12Djj2clV@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-12-skhawaja@google.com>
 <666d749e-c1fd-44e1-bfe8-681ba04862e0@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <666d749e-c1fd-44e1-bfe8-681ba04862e0@linux.intel.com>

On Fri, May 08, 2026 at 02:05:58PM +0800, Baolu Lu wrote:
>On 4/28/26 01:56, Samiullah Khawaja wrote:
>>In scalable mode the PASID table is used to fetch the io page tables.
>>Preserve and restore the PASID table of the preserved devices.
>>
>>Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c      |   5 +-
>>  drivers/iommu/intel/iommu.h      |  12 +++
>>  drivers/iommu/intel/liveupdate.c | 141 +++++++++++++++++++++++++++++++
>>  drivers/iommu/intel/pasid.c      |   7 +-
>>  drivers/iommu/intel/pasid.h      |   9 ++
>>  include/linux/kho/abi/iommu.h    |  13 +++
>>  6 files changed, 184 insertions(+), 3 deletions(-)
>>

[snip]
>>+
>>+void pasid_cleanup_preserved_table(struct device *dev)
>>+{
>>+	struct pasid_table *pasid_table;
>>+	struct pasid_dir_entry *dir;
>>+	struct pasid_entry *table;
>>+	size_t dir_size;
>>+
>>+	pasid_table = intel_pasid_get_table(dev);
>>+	if (!pasid_table)
>>+		return;
>>+
>>+	dir = pasid_table->table;
>>+	table = get_pasid_table_from_pde(&dir[0]);
>>+	if (!table)
>>+		return;
>>+
>>+	/* Clear everything except the first entry in table. */
>>+	memset(&table[1], 0, SZ_4K - sizeof(*table));
>>+
>>+	/* Use the folio order to calculate the size of Pasid Directory */
>>+	dir_size = (1 << (folio_order(virt_to_folio(dir)) + PAGE_SHIFT));
>>+
>>+	/* Clear everything except the first entry in directory */
>>+	memset(&dir[1], 0, dir_size - sizeof(struct pasid_dir_entry));
>>+
>>+	clflush_cache_range(&table[0], SZ_4K);
>>+	clflush_cache_range(&dir[0], dir_size);
>>+}
>
>The PASID table is currently active and in use by the hardware. Clearing
>the entries without the necessary hardware cache invalidation is buggy.
>
>It seems this manual clearing is a workaround because PASID domain
>preservation isn't supported yet. If so, rather than clearing the table
>blindly, the code should verify if any PASIDs (other than
>IOMMU_NO_PASID) are actually in use. If there are, the preserve callback
>should return an error.

Thanks for looking into this, I agree and will remove the clearing logic
here.

Yes, we do this check in iommufd, as it is the dma owner of the device,
and only DMA owned devices are allowed to be preserved.

During preservation iommufd returns an error if the device has PASID
(non NO_PASID) attachments. And once the device is preserved, any PASID
attachments are not allowed until the device is unpreserved.

I think I will make this check robust by moving it into core and use
pasid_array. It will require some plumbing as pasid_array exists in
iommu.c file.
>
>Or anything I overlooked here?
>
>Thanks,
>baolu

Thanks,
Sami

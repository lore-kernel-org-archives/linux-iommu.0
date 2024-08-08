Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868C412FB0A
	for <iommu@lists.linux.dev>; Thu,  8 Aug 2024 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723135228; cv=none; b=sL0OO5CgpHh6aSkAwMqCz1ge2ZsaiN+bqrhLmgxC+y80eJlp/dm6YXY77lVTki5xb0AGTbXaE1Hb6QnS0l7aHUHuNV0sxcPbNloqVK5OFQFOt+iEKpCNw8ccXIxw2dWbpdwoV8w4slO9retuYYIGnIwQ4ZRy3oEJg8VFoEggvPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723135228; c=relaxed/simple;
	bh=tJHROCF5FIFH333VZcXU5J5IzhpJm677qL7yxSNpeu4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P0wvuLfMaahDyXH+99kA54JaedEVpp9ktQ02DMR4OBEsX+fp75GFFS7VmlQbbcQ6l6OILhNd4NpKr2dONFhAbT/SKzHR2AQjKmyllNSGDY6fh4A7rUzpvuGlT/PiFJcl+XfvwBR+0mseNLFIWhbyJLqPHqP/SS8plzxsWfKaqMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PzG10cld; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PzG10cld"
Received: from [100.65.224.131] (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7F15220B7165;
	Thu,  8 Aug 2024 09:40:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7F15220B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1723135227;
	bh=pNSyKAAFSaByPF2gZY6jQTEMrj9M3d4OIOtRITHeq2M=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=PzG10cldv/Tk+MgEh4nS+eROzyXE6w8cgUoROcA4GmIs13++8agdcClHJjbxidRRy
	 nkoLbnPDXPxTaCyWCFmNBbexGH1nWJtNJwXe1emvT9Q8Pka/vPOatVx7jRmy1v2nf/
	 XmiFwcy3ncserwcahCn4oKWurg9NWbyTkVFcVNEo=
Message-ID: <7dfff1ba-44a6-465a-a47c-d344ef00c6d5@linux.microsoft.com>
Date: Thu, 8 Aug 2024 09:40:25 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Nick Kossifidis <mick@ics.forth.gr>,
 Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux@rivosinc.com, Lu Baolu <baolu.lu@linux.intel.com>,
 Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v8 7/7] iommu/riscv: Paging domain support
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <cover.1718388908.git.tjeznach@rivosinc.com>
 <bdd1e0547e01d012bf40c5e33b752e77c6663c90.1718388909.git.tjeznach@rivosinc.com>
 <389da90e-df78-4ea4-8453-ae2080a68956@linux.microsoft.com>
 <20240808131432.GB1985367@ziepe.ca>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <20240808131432.GB1985367@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/2024 6:14 AM, Jason Gunthorpe wrote:
> On Tue, Aug 06, 2024 at 12:24:40PM -0700, Easwar Hariharan wrote:
>> On 6/14/2024 10:27 PM, Tomasz Jeznach wrote:
>>
>>> @@ -856,7 +1473,7 @@ static struct iommu_domain riscv_iommu_identity_domain = {
>>>  
>>>  static int riscv_iommu_device_domain_type(struct device *dev)
>>>  {
>>> -	return IOMMU_DOMAIN_IDENTITY;
>>> +	return 0;
>>>  }
>>
>> <snip>
>> Sorry for the drive by comment, I just happen to be in the nearby code
>> context.
>>
>> Nit: It may be better to use IOMMU_DOMAIN_BLOCKED here for readability
>> rather than the bare value.
> 
> It is weird and confusing, but 0 means "I have nothing to add" not
> BLOCKED.
> 
> You can't return BLOCKED from this op right now..
> 
> Jason

Ok, that's weird and confusing as you say. I went back and looked at the
kerneldoc for iommu_ops and it IS called out, but it's confusing that a
function named get_default_domain_type() can return a value that's a
valid domain type but isn't treated as one.

This was useful to fill in my mental model, thanks!

Easwar

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792796658;
	b=Sr57KRfQVl9g/2xobmAg8SQ5XhaauJGh1cuNYKSxeXz3PtQPwmNmveMI75V2BrmOvudS
	 xB2qSY9VBLfFhzAjP2hwpJg0ogS8nVA/WfZuKsJeoPJBofPZXwqhf2rpuI+fPPwEFUIKd
	 kkxUmYsyQyM0sY+PVHFDUYZbu0aTV8qubAkW+PPaxDSabX7Jecko2nWZWyjQp1r/6ooNB
	 BK64hvG/xiqinvvs8ePjWMb7OPVV8bCccUf5nsp/ZMcGxvNoA9YV7/puixGST26VaVCfj
	 MP2ln+UIWaotIi2jZwb9HpYoC7kXsQUXh35UN0qjpYqtUawcBR/KcBGo1gkzWB78dMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792796658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=3xbNbatCe41SldMriSPTRQF+PIc5nLUyNrQZ+W+A7/U=;
	b=aKes1JBWJXYNxMS91oYsy0qk7fpfuKP5/US4t0UYMAXou+5DjVA9XOCxDeWXf4uGG/ZC
	 tCMJwhUUNn+A0wWyKSf6pPH5QHpMFK2AUomNzl6Ttyj0+o3en7OtCKJKfetlG7M3LCQU0
	 UK20MxmAiq2sOzbrS9ZwuzoZigia1ZdmJTJnX4zb+rJ1WuV/pAzohRq+PDqeHNm/hD67R
	 Oy75PI6Ie3fjQ5PunGMr+ZluizESHEgc6+lTMX5WAiS5s6Tg/St7yMm7/pt/tCAfL3sPh
	 OeKqghx41m6NPTOz+ZLJAtc0KMmqmjWRjUMgyL5cE/TR6iI+O7ly0Dx3ItsHw9/7ITA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Qz7gnite;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0422D606A31B
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 23:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0422D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Qz7gnite
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ea7f9c11e6so23765ad.0
        for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 16:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792796657; x=1793401457; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3xbNbatCe41SldMriSPTRQF+PIc5nLUyNrQZ+W+A7/U=;
        b=Qz7gnitebPBSd3tB1+sUoc5dDDJM9U30FwFD31brSCfRirpVQfcVYwqeDIMxMQ0SEC
         kEFCJ51amKIZ291VW/l189KPRnud3zKodxm6e+DLOT5FALPHi5CRK2gfYb0+Hu3b8BTB
         CfbbSbmyuUZwBY315ditfaSIYbSXiRPbuoTtDruUluyvvuJgdDq2Yt4gHHm3IJATqCfF
         nNAIg6ORJC7hO5hGLd4cGMnqgrzq27E+m7NAiQER1KX5PrO4WdYAjAhY4vI5D0h3IK6t
         ABzRZfbGdryvZugkAFmPc//Dato5SXnBx1/Qv5YTUn5oOqTpLynu08Nntx3VEdnna4z3
         UCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792796657; x=1793401457;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3xbNbatCe41SldMriSPTRQF+PIc5nLUyNrQZ+W+A7/U=;
        b=keoxGSTR22wWUkpgGL/7N/HftTHWI4ory2lUSbaL1vkYWSzy51mnsD255aWamY0Pbn
         ddBJsEtdGAoetlmGhUZEcYndx5zvQrglU63O55/sqeASVcmuB4mZ6624jpCLmQSH1Kyj
         TiP13jc9AarTVxU8ZGARv73ljvN/OSHuTHcgDt5LqKCzo+H58VfIQWihZKZS69eeAf1Y
         EUZzTWYEwvBtLk93cX1+XoFGSjjl28uKumvzGPuYG6SjZ771dwdPXgDrImMQtrNsRDoS
         xpdwkNp/R8DExIXUhIWEyLymJPPu8fGPeEFR6JJoE2njIgpD9XafSfKbZmfSQ8lfuul9
         YSUw==
X-Forwarded-Encrypted: i=1; AKwUvBwJLSykrV9ACKQ/PaBb090hywY2d6Rf1BWItCE01fEqDutRGZACLjgG8JnqP0LN3TF1c88jjQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYI0cxkNCtgwYNrf+PFiyVhnzG51Ecy+dWq8HIHs3uKTgAN2UYIi
	CP7ynqiZdodF1yhz07+bvPXdS9aaG3RdW/QIOKc1aHJeG2FCvK/bK1zWpQF6u7f1JQ==
X-Gm-Gg: AYBFou1kxegciZs8ZRErNjghEvTxG8t8u4QfbOy5jhhk4wJNVSbILHRi9T5k/e4lk5S
	3Bhg+8WCatjjt1fJv4JosqPbJ+uUTvyFufva7WRvhU3gdYMTsrY6Qg9QmgZ9hVV30/eaceNVmJQ
	Sho6UAXpY0eTqHj/UQCDJH/JCfKJp5q1lrC8wYdVVUEzZIhIhzfMh8OJY6PFa5RvB1NK9xG88CG
	5RULVp3xcM4KEQs7+8Soe8HzuZpAzk4v9lHadsiFrklbGTWkk/l2OwhKsWCXkgKEJZx/m34AjH7
	RIqI5gwrcc//30zm7sW9KrkpkSWyhlRrReSPXpH2wkq/3+bfU86bNQAH+QM+JrgqxSbxdyAEQYe
	FloVi4vt/GGmr9bCNfCc/9LjlA305rbPNhKMjli4zGNMSDCPGftL0hDLKYsalkQTS8MFxLbLOC+
	WhiHT8ZfPeKDhKkJuEoGwLsdpO8V18qhRP/hJmVrTqao1ZdoUFK9xIjUED/gixf2XdCM/pZmW+Y
	SocBMEL+wM/VRrCc3gv7b14+qsCv5bpncRrMelQOrpxhefgnn7KvfZw9hVJi9H+LNgJTeySspJJ
	BTuvF39Pp7/WeftKMe6+bBgarMBe8ojQrn582wFoUCJ9dzv1jUEJEGpvgekyBhTeKh0C0g==
X-Received: by 2002:a17:903:37c6:b0:2e3:981:4cc4 with SMTP id d9443c01a7336-2ea9d142431mr730895ad.9.1792796656506;
        Fri, 23 Oct 2026 16:04:16 -0700 (PDT)
Received: from google.com (163.1.145.34.bc.googleusercontent.com. [34.145.1.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb0dda7sm385580a91.4.2026.10.23.16.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 16:04:14 -0700 (PDT)
Date: Fri, 23 Oct 2026 23:04:10 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Pranjal Shrivastava <praan@google.com>
Subject: Re: [RFC PATCH 1/3] vfio: selftests: Add support of creating iommus
 from iommufd
Message-ID: <atvm5B7zhe5n1A_-@google.com>
References: <20260925011308.3381953-1-skhawaja@google.com>
 <20260925011308.3381953-2-skhawaja@google.com>
 <atk6drL0jn8A9Ocm@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <atk6drL0jn8A9Ocm@google.com>

On Wed, Oct 21, 2026 at 10:19:34PM +0000, David Matlack wrote:
>On 2026-09-25 01:13 AM, Samiullah Khawaja wrote:
>> Add API to init a struct iommu using an already opened iommufd instance
>> and attach devices to it.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  .../vfio/lib/include/libvfio/iommu.h          |  2 +
>>  .../lib/include/libvfio/vfio_pci_device.h     |  2 +
>>  tools/testing/selftests/vfio/lib/iommu.c      | 60 +++++++++++++++++--
>>  .../selftests/vfio/lib/vfio_pci_device.c      | 25 ++++++--
>>  4 files changed, 80 insertions(+), 9 deletions(-)
>>
>> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
>> index e9a3386a4719..62f1e8affd2b 100644
>> --- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
>> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
>> @@ -29,10 +29,12 @@ struct iommu {
>>  	int container_fd;
>>  	int iommufd;
>>  	u32 ioas_id;
>> +	u32 hwpt_id;
>>  	struct list_head dma_regions;
>>  };
>>
>>  struct iommu *iommu_init(const char *iommu_mode);
>> +struct iommu *iommufd_iommu_init(int iommufd, u32 dev_id);
>>  void iommu_cleanup(struct iommu *iommu);
>>
>>  int __iommu_map(struct iommu *iommu, struct dma_region *region);
>> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
>> index e19bd94b8dd2..4dcc23bc9b78 100644
>> --- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
>> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
>> @@ -19,6 +19,7 @@ struct vfio_pci_device {
>>  	const char *bdf;
>>  	int fd;
>>  	int group_fd;
>> +	u32 dev_id;
>>
>>  	struct iommu *iommu;
>>
>> @@ -82,6 +83,7 @@ static inline void vfio_pci_cmd_clear(struct vfio_pci_device *device, u16 bits)
>>  	vfio_pci_config_writew(device, PCI_COMMAND, cmd & ~bits);
>>  }
>>
>> +void vfio_pci_device_attach_iommu(struct vfio_pci_device *device, struct iommu *iommu);
>>  void vfio_pci_irq_enable(struct vfio_pci_device *device, u32 index,
>>  			 u32 vector, int count);
>>  void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index);
>> diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
>> index b6f3c5c84e01..6d2d5c82813c 100644
>> --- a/tools/testing/selftests/vfio/lib/iommu.c
>> +++ b/tools/testing/selftests/vfio/lib/iommu.c
>> @@ -405,6 +405,18 @@ struct iommu_iova_range *iommu_iova_ranges(struct iommu *iommu, u32 *nranges)
>>  	return ranges;
>>  }
>>
>> +static u32 iommufd_hwpt_alloc(struct iommu *iommu, u32 dev_id)
>> +{
>> +	struct iommu_hwpt_alloc args = {
>> +		.size = sizeof(args),
>> +		.pt_id = iommu->ioas_id,
>> +		.dev_id = dev_id,
>> +	};
>> +
>> +	ioctl_assert(iommu->iommufd, IOMMU_HWPT_ALLOC, &args);
>> +	return args.out_hwpt_id;
>> +}
>> +
>>  static u32 iommufd_ioas_alloc(int iommufd)
>>  {
>>  	struct iommu_ioas_alloc args = {
>> @@ -415,17 +427,25 @@ static u32 iommufd_ioas_alloc(int iommufd)
>>  	return args.out_ioas_id;
>>  }
>>
>> -struct iommu *iommu_init(const char *iommu_mode)
>> +static struct iommu *iommu_alloc(const char *iommu_mode)
>>  {
>> -	const char *container_path;
>>  	struct iommu *iommu;
>> -	int version;
>>
>>  	iommu = calloc_assert(1, sizeof(*iommu));
>>
>>  	INIT_LIST_HEAD(&iommu->dma_regions);
>>
>>  	iommu->mode = lookup_iommu_mode(iommu_mode);
>> +	return iommu;
>> +}
>> +
>> +struct iommu *iommu_init(const char *iommu_mode)
>> +{
>> +	const char *container_path;
>> +	struct iommu *iommu;
>> +	int version;
>> +
>> +	iommu = iommu_alloc(iommu_mode);
>>
>>  	container_path = iommu->mode->container_path;
>>  	if (container_path) {
>> @@ -449,10 +469,42 @@ struct iommu *iommu_init(const char *iommu_mode)
>>  	return iommu;
>>  }
>>
>> +struct iommu *iommufd_iommu_init(int iommufd, u32 dev_id)
>
>I think this is a good opportunity to start adding kernel-doc comments.
>It's not very obvious how and when to use both iommufd_iommu_init() and
>vfio_pci_device_attach_iommu(). A kernel-doc comment would help clarify
>that.

Agreed. I will add it.
>
>> +{
>> +	struct iommu *iommu;
>> +
>> +	iommu = iommu_alloc("iommufd");
>> +
>> +	iommu->iommufd = dup(iommufd);
>> +	VFIO_ASSERT_GT(iommu->iommufd, 0);
>> +
>> +	iommu->ioas_id = iommufd_ioas_alloc(iommu->iommufd);
>> +	iommu->hwpt_id = iommufd_hwpt_alloc(iommu, dev_id);
>> +
>> +	return iommu;
>> +}
>> +
>> +static void iommufd_cleanup(struct iommu *iommu)
>> +{
>> +	struct iommu_destroy args = {
>> +		.size = sizeof(args),
>> +	};
>> +
>> +	if (iommu->hwpt_id) {
>> +		args.id = iommu->hwpt_id;
>> +		ioctl_assert(iommu->iommufd, IOMMU_DESTROY, &args);
>> +	}
>> +
>> +	args.id = iommu->ioas_id;
>> +	ioctl_assert(iommu->iommufd, IOMMU_DESTROY, &args);
>
>Please put IOMMU_DESTROY into its own helper so this can be:
>
>if (iommu->hwpt_id)
>        iommufd_iommu_destroy(iommu, iommu->hwpt_id);
>
>iommufd_iommu_destroy(iommu, iommu->ioas_id);

Will do
>
>> +
>> +	VFIO_ASSERT_EQ(close(iommu->iommufd), 0);
>> +}
>> +
>>  void iommu_cleanup(struct iommu *iommu)
>>  {
>>  	if (iommu->iommufd)
>> -		VFIO_ASSERT_EQ(close(iommu->iommufd), 0);
>> +		iommufd_cleanup(iommu);
>>  	else
>>  		VFIO_ASSERT_EQ(close(iommu->container_fd), 0);
>>
>> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
>> index 774d1e90ec0e..81d3879d064f 100644
>> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
>> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
>> @@ -469,15 +469,15 @@ int __vfio_device_bind_iommufd(int device_fd, int iommufd, const char *vf_token)
>>  	if (ioctl(device_fd, VFIO_DEVICE_BIND_IOMMUFD, &args))
>>  		return -errno;
>>
>> -	return 0;
>> +	return args.out_devid;
>
>This breaks vfio_pci_sriov_uapi_test for all iommufd variants (9/45
>fail). iommufd_setup() in that test returns the result of
>__vfio_device_bind_iommufd() directly, and the
>fixture/ASSERT_COND_VF_CREATION() treat any non-zero value as failure.
>
>Something like the following is needed to fix it:
>
>diff --git a/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c b/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
>--- a/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
>+++ b/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
>@@ -32,9 +32,14 @@ static int container_setup(struct vfio_pci_device *device, const char *bdf,
> static int iommufd_setup(struct vfio_pci_device *device, const char *bdf,
>		  const char *vf_token)
> {
>+    int ret;
>+
>     vfio_pci_cdev_open(device, bdf);
>-    return __vfio_device_bind_iommufd(device->fd,
>-                      device->iommu->iommufd, vf_token);
>+    ret = __vfio_device_bind_iommufd(device->fd,
>+                     device->iommu->iommufd, vf_token);
>+
>+    /* On success, __vfio_device_bind_iommufd() returns the device ID. */
>+    return ret < 0 ? ret : 0;
> }
>
> static int device_init(const char *bdf, struct iommu *iommu,

Will update.
>
>>  }
>>
>> -static void vfio_device_bind_iommufd(int device_fd, int iommufd,
>> -				     const char *vf_token)
>> +int vfio_device_bind_iommufd(int device_fd, int iommufd, const char *vf_token)
>>  {
>>  	int ret = __vfio_device_bind_iommufd(device_fd, iommufd, vf_token);
>>
>> -	VFIO_ASSERT_EQ(ret, 0, "Failed VFIO_DEVICE_BIND_IOMMUFD ioctl\n");
>> +	VFIO_ASSERT_GE(ret, 0, "Failed VFIO_DEVICE_BIND_IOMMUFD ioctl\n");
>> +	return ret;
>>  }
>>
>>  static void vfio_device_attach_iommufd_pt(int device_fd, u32 pt_id)
>> @@ -503,10 +503,25 @@ static void vfio_pci_iommufd_setup(struct vfio_pci_device *device,
>>  				   const char *bdf, const char *vf_token)
>>  {
>>  	vfio_pci_cdev_open(device, bdf);
>> -	vfio_device_bind_iommufd(device->fd, device->iommu->iommufd, vf_token);
>> +	device->dev_id = vfio_device_bind_iommufd(device->fd, device->iommu->iommufd, vf_token);
>>  	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
>>  }
>>
>> +void vfio_pci_device_attach_iommu(struct vfio_pci_device *device, struct iommu *iommu)
>> +{
>> +	u32 pt_id = iommu->ioas_id;
>> +
>> +	/* Only iommufd supports changing struct iommu attachments */
>> +	VFIO_ASSERT_TRUE(iommu->iommufd);
>> +
>> +	if (iommu->hwpt_id)
>> +		pt_id = iommu->hwpt_id;
>> +
>> +	VFIO_ASSERT_NE(pt_id, 0);
>
>Is this assert needed? (Will vfio_device_attach_iommufd_pt() not handle
>this appropriately?)

It should be covered by the assert for the ioctl. I will remove this.
>
>> +	vfio_device_attach_iommufd_pt(device->fd, pt_id);
>> +	device->iommu = iommu;
>> +}
>> +
>>  struct vfio_pci_device *vfio_pci_device_alloc(const char *bdf, struct iommu *iommu)
>>  {
>>  	struct vfio_pci_device *device;
>> --
>> 2.56.0.rc1.315.gc6ed9934b7-goog
>>

Thanks,
Sami

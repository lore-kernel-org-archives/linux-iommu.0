Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793675876;
	b=PubT8wOGn5EaikSqhmYQb0J2kyt1qmIb9jRGMm8ykmVUhRAGRrlujFog2aWCXIHOxW5Y
	 rWfJEchBL/RfEV56ZwY43mkcXtJK4zkHBXXFzrHQcVBC5UgLPnmGDHzSvP6yQgdbN877Q
	 fArhWc4/9fANAGdO24wbP9VT1hxasFdFQ7KLVUxu5wAoR6lxhxtrNSwtfgCjZjXqG2oVS
	 QAApXOmUde6FQXSQn65KvXid43yY3HAd8Lo4JK1trmBVH8/pq2RNLMg8Q3a4y/Jsa+p0l
	 EW4uKA1XrFbtdk1sO0Dep62eqW2xpVbEm+AWXd3xnVah1ifEBP7Mc/rXGgrwYfWXYnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793675876;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=Bq8RxOjp221zCtPe1b7ySNgeViySYgXEXgz3pYeX0SQ=;
	b=yu8CtVb0rcgXoy2jnS0UgS25bx6FceNKRCmfyiMZX4Xek1ZRobz7J2LBd5D+y61NKbnl
	 C6J2CsI6RGwbVb6FOT9hztLXwezCUu9qXj5pKNaw9JI6HfXU6PPgmEo9Ft+HdQRDVvzSr
	 h1DrZqigzqYYjD5LDKlhrn1Y03PBA1T+Qz3PMDCMbvl9pqKpbf+y9wuYyw1StIMwVFCNz
	 p0bZrg+Cz3vC+PwoEl9+uxm+rkkMHS1O9FYqrU14AtEEvCUGbwVfb8auU7qRKDTze0ih2
	 qm0dWMW6W5amUaFJYkygT1IZdLblbfO+oNzk8BYs+99Q+4fCF1hGzJofyZhd1lroJQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=RyF6tFSs;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFB1606A327
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 03:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CFB1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=RyF6tFSs
Received: from [192.168.166.159] (unknown [67.168.101.66])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8037E20B7166;
	Mon,  2 Nov 2026 19:17:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8037E20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793675861;
	bh=Bq8RxOjp221zCtPe1b7ySNgeViySYgXEXgz3pYeX0SQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=RyF6tFSsYqXm9Tp4+4N/XOnFIwW2lrHGXaHlZIlq4MPN0j0IplShWpzIYBlPy5MeV
	 oQMB05jEY1RJ1LDQ/KzVf+VSv0kRgouPv9xpRLvjldr4wQyiXc/XmqIP+RzmhWXX8J
	 onuVe6gt7rrUN7PgRRsxwVrTk6FI+cNaV5ZOY9Ds=
Message-ID: <dc41f6b6-413f-4340-9579-6853f2d5d565@linux.microsoft.com>
Date: Mon, 2 Nov 2026 19:17:55 -0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 easwar.hariharan@linux.microsoft.com, jgg@nvidia.com,
 jacob.pan@linux.microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, arnd@arndb.de
Subject: Re: [PATCH V3 3/5] mshv: Import data structs around device domains
 from hyperv headers
To: Mukesh R <mrathor@linux.microsoft.com>
References: <20261103025150.3192119-1-mrathor@linux.microsoft.com>
 <20261103025150.3192119-4-mrathor@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20261103025150.3192119-4-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/2026 18:51, Mukesh R wrote:
> Copy/import from Hyper-V public headers, definitions and hypercalls that
> are related to checking for device domain availibility, and mapping and
> unmapping of device pages.
> 
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> ---
>  include/hyperv/hvgdk_mini.h |  4 ++++
>  include/hyperv/hvhdk_mini.h | 15 +++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 966945f0504f..606b16f43e16 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -327,6 +327,8 @@ union hv_hypervisor_version_info {
>  /* stimer Direct Mode is available */
>  #define HV_STIMER_DIRECT_MODE_AVAILABLE			BIT(19)
>  
> +#define HV_DEVICE_DOMAIN_AVAILABLE			BIT(24)
> +
>  /*
>   * Implementation recommendations. Indicates which behaviors the hypervisor
>   * recommends the OS implement for optimal performance.
> @@ -489,6 +491,8 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
>  #define HVCALL_CREATE_DEVICE_DOMAIN			0x00b1
>  #define HVCALL_ATTACH_DEVICE_DOMAIN			0x00b2
> +#define HVCALL_MAP_DEVICE_GPA_PAGES			0x00b3
> +#define HVCALL_UNMAP_DEVICE_GPA_PAGES			0x00b4
>  #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
>  #define HVCALL_POST_MESSAGE_DIRECT			0x00c1
>  #define HVCALL_DISPATCH_VP				0x00c2
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index 57b70efe60d4..2bb757e00d86 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -549,6 +549,7 @@ union hv_device_id {		/* HV_DEVICE_ID */
>  } __packed;
>  
>  /* Device domain types */
> +#define HV_DEVICE_DOMAIN_TYPE_S2	0 /* HV_DEVICE_DOMAIN_ID_TYPE_S2 */
>  #define HV_DEVICE_DOMAIN_TYPE_S1	1 /* HV_DEVICE_DOMAIN_ID_TYPE_S1 */
>  
>  /* ID for default domain and NULL domain */
> @@ -657,6 +658,20 @@ struct hv_output_get_iommu_capabilities {
>  	u64 pgsize_bitmap;
>  } __packed;
>  
> +struct hv_input_map_device_gpa_pages { /* HV_INPUT_MAP_DEVICE_GPA_PAGES */
> +struct hv_input_device_domain device_domain;

Nit: Needs whitespace

> +	union hv_input_vtl target_vtl;
> +	u8 padding[3];
> +	u32 map_flags;
> +	u64 target_device_va_base;
> +	u64 gpa_page_list[];
> +} __packed;
> +
> +struct hv_input_unmap_device_gpa_pages {  /* HV_INPUT_UNMAP_DEVICE_GPA_PAGES */
> +	struct hv_input_device_domain device_domain;
> +	u64 target_device_va_base;
> +} __packed;
> +
>  /* HV_LOGICAL_DEVICE_PROPERTY_CODE */
>  enum hv_logical_device_property_code {
>  	HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU = 10,


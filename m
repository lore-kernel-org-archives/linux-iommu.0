Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5077B
	for <iommu@lists.linux.dev>; Sat, 12 Nov 2022 00:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668212510; x=1699748510;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=j1lAUzMwl/IGPrbGdS61ib0IEbELaXeyWascY1TXhxo=;
  b=aQnAbxPyF9RVn3scEzQ/7p8Qix1FaVe6jWSCyMbXomzTZ0SHAGQwFfGe
   2p3C84rjcT4Wfakv/ATxTHMougy38pWi5yEqBTrg28ap13O2pXuk35AHF
   mlnVV8UfjMiHbKGrigdnli7cgUZVJOxvQoJLEzKpUvV3ZdF7NXHtQ47V8
   WRLF8jPLdTLX+/ZI8whVqkh5de+bATrZCPcyE1ztj0R2BtBopJYsSbLi3
   IozF/7Jt9LTzPBqWm89TQ7XYm3lTt8j8mN1ljwRVlaPnb70xPzps8ugNa
   jEcXYrq4dAhxTLq5fyNTfpHZOf+c1mnZptGQmOuh7mYyUs/8CH6SXCIz3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="299198566"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="299198566"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 16:21:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="726928308"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="726928308"
Received: from nmpoonaw-mobl1.amr.corp.intel.com (HELO [10.252.134.46]) ([10.252.134.46])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 16:21:47 -0800
Message-ID: <50a8517d-328e-2178-e98c-4b160456e092@intel.com>
Date: Fri, 11 Nov 2022 16:21:45 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 02/12] x86/ioapic: Gate decrypted mapping on
 cc_platform_has() attribute
Content-Language: en-US
To: Michael Kelley <mikelley@microsoft.com>, hpa@zytor.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, luto@kernel.org, peterz@infradead.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
 bhelgaas@google.com, arnd@arndb.de, hch@infradead.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com, thomas.lendacky@amd.com,
 brijesh.singh@amd.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, Tianyu.Lan@microsoft.com,
 kirill.shutemov@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 ak@linux.intel.com, isaku.yamahata@intel.com, dan.j.williams@intel.com,
 jane.chu@oracle.com, seanjc@google.com, tony.luck@intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, iommu@lists.linux.dev
References: <1668147701-4583-1-git-send-email-mikelley@microsoft.com>
 <1668147701-4583-3-git-send-email-mikelley@microsoft.com>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <1668147701-4583-3-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/22 22:21, Michael Kelley wrote:
>  	 * Ensure fixmaps for IOAPIC MMIO respect memory encryption pgprot
>  	 * bits, just like normal ioremap():
>  	 */
> -	flags = pgprot_decrypted(flags);
> +	if (!cc_platform_has(CC_ATTR_HAS_PARAVISOR))
> +		flags = pgprot_decrypted(flags);

This begs the question whether *all* paravisors will want to avoid a
decrypted ioapic mapping.  Is this _fundamental_ to paravisors, or it is
an implementation detail of this _individual_ paravisor?

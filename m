Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE5A374E79
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 22:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772577775; cv=none; b=BioJlaFznWN0hh8XnIqNQ0h1uCuEHPrN7h6ei9VZbQRCaUu5Kb2FIjJMXbaU1JDBJvfZQrD86JMcVjjKYsBObscq+SSEgtqtJVwJbQSARE/u2dlGxWhdMzhh0TACl1SpJZ0mUukXqOjEA46h4ARBQFM8nFuB+u9KRsnGLp97i2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772577775; c=relaxed/simple;
	bh=yoy6NsCRcbuV9Umi5CYwIZKfZgmmMPIYStSiCisZb4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Li5O8yPWaZXhAPI+14s7Kgh7yXVP9ZJjIyBf6HYfMhu7h5nVCFvY6Q5TagJ8pE1VH1jX42kykXF3t+CadErqiZo6Gc2ANvIEhYBGpNhDUUAnyn5p5IWSdpSJjSV9DaONE3b0j5LpCeo4OSG7XowjNYCHQvBGVtsAoy+34vHi+wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tJfwL8HI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tJfwL8HI"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ae523d54d2so122855ad.1
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 14:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772577773; x=1773182573; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yZQeApSUQxpoAbpvHaUWfr7VRKfxZHqPPWf4+EFlsX0=;
        b=tJfwL8HI+cTC8Hrw2FD+m287wbhQj1kJttnmpOcp+YepaRE8sJwbkWYT6KoFCbs6Kj
         Zm0cmAhFzL6fpFURN6csuEM1ZirdyVMkSwz9yMJ+Fn/4jbzNmrmEG1Jzdo1P+FHt6103
         +Dc+XyaN3PC18AJufw5DdA84w/txTRtevDo+TS9KtlwYaVDElLFhQ2CfEujKp053sVx2
         WPbLsiJVrZz9WrnPQ/8VvnuJqtu3VVHnGZXyxWTJZo9crtm3oCVMTWyzeigp/b++Qohc
         YQ03f7j8IbKWkab1KHDeOF8rlkfnk2r4uM+NTu0Ia9vlxwib9LaUlYwcxLu6ux4Ui2YC
         Dokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772577773; x=1773182573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZQeApSUQxpoAbpvHaUWfr7VRKfxZHqPPWf4+EFlsX0=;
        b=T2BXTGuJgUqTUOeYG4fh6Hn+8EX5ZmVllyyU3b6acPmjE46/ZPzFbXXWxbEtTSVlj+
         JT+SfJetHWtL+aonktL5deXM2YcHnNexMhepsHtLwth/C54rgon6tZCMv8PaisbA+eLq
         DFC0ZrP7s9n5QnrnmL4OIkH9qRfrN9Rv5PhpvToLN38hMKPs/yLaCNE3lYHEpChaHJnl
         cC5VMGc3BgwlGNvE32c2HadEb6KmSnHhp8dD5F86ZfVQUa0Tnby/21zoZlpurCAHRA39
         7+z6V0XsMhGAZW3agZJjmnv8xyDFbT5Gdhfn6E7lIn9sT3WuINXZHOPziO1N6WzTaU13
         pdSA==
X-Gm-Message-State: AOJu0Yxua6GD6+la6jdXp+rER+Nxvu6YJ1l0E7xKHcCa2zERcVfDnOVH
	S18Av446jkLrLltfIDXIfKlBynXeTsHv4irDUhFluZUJUcUcSzYljdc5lkDqiUlRjw==
X-Gm-Gg: ATEYQzzpaB4yDORqryux+I+1SYVzGsxXLSGtl2qoeRryofwpaCgdijr5nJvwA48x8p9
	0VrZ32fHkMJcN7gbh/g64jYrzp8O8VYAEIZdi1lE3mg92w9UonsPBbBs/Kv9gRken7BNUVC87wE
	8rkC7XxXAT5U51217YnZGBdoX6x4QCjrTBYVYBiDEkMuzYtJeUQSz+Trvsv2LcOCY3KLy2opfgX
	kLyjSRzUUlREi3K06xWnbDuIxahV0C7YvQGJ1kIzUXQV4F7HdxTQ/oXqKRueP6pjI4Ln9Mw/BCh
	+LmqeC9ujDkCANxtfB7Id1GokS2LK25fjZF1HWM7nhwvE0AMdJ5aPz6kvTh2F5YKYe+YHMPqdv2
	y88jKEVVeGRPQRr+JrwsiZtrkg4YOrMBEPSPkgtQ8PhE/uGFX0/gwW/L1H3A89WK9zXZkj4PRB6
	otHvCv/V3VL25RojVhgL/oDF8Uo7zFopSzdfHUut4pUK4kZgJFuOsm6qBDASXpyQ==
X-Received: by 2002:a17:902:b7cc:b0:2ae:44db:570c with SMTP id d9443c01a7336-2ae44db6092mr3991105ad.12.1772577772937;
        Tue, 03 Mar 2026 14:42:52 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d4d93dsm16714852b3a.3.2026.03.03.14.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 14:42:52 -0800 (PST)
Date: Tue, 3 Mar 2026 22:42:48 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, baolu.lu@linux.intel.com, jgg@ziepe.ca, 
	kevin.tian@intel.com, nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, 
	kjaju@nvidia.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 1/2] iommu: Add device ATS not supported capability
Message-ID: <p435ycx3b27d5gpzcli2kbp4eh36fq2ufgkft3hf3rqgqfx7i6@oql6hovzwkju>
References: <20260303150348.233997-1-skolothumtho@nvidia.com>
 <20260303150348.233997-2-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260303150348.233997-2-skolothumtho@nvidia.com>

On Tue, Mar 03, 2026 at 03:03:47PM +0000, Shameer Kolothum wrote:
>PCIe ATS may be disabled by platform firmware, root complex limitations,
>or kernel policy even when a device advertises the ATS capability in its
>PCI configuration space.
>
>Add a new IOMMU_CAP_PCI_ATS_NOT_SUPPORTED capability to allow IOMMU
>drivers to report the effective ATS decision for a device.

nit: Maybe have IOMMU_CAP_PCI_ATS_SUPPORTED instead of the negative
variant of the capability. As this will affect only new users who might
check this capability so this does not really have to be negative.
>
>When this capability is returned true for a device, ATS is not
>supported and not used for that device, regardless of the presence
>of the PCI ATS capability.
>
>A subsequent patch will extend iommufd to expose the effective ATS
>status to userspace.
>
>Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>---
> include/linux/iommu.h                       | 2 ++
> drivers/iommu/amd/iommu.c                   | 6 ++++++
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 +++
> drivers/iommu/intel/iommu.c                 | 2 ++
> 4 files changed, 13 insertions(+)
>
>diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>index 54b8b48c762e..f40ecdc5d761 100644
>--- a/include/linux/iommu.h
>+++ b/include/linux/iommu.h
>@@ -271,6 +271,8 @@ enum iommu_cap {
> 	 */
> 	IOMMU_CAP_DEFERRED_FLUSH,
> 	IOMMU_CAP_DIRTY_TRACKING,	/* IOMMU supports dirty tracking */
>+	/* ATS is not supported and not used on this device */
>+	IOMMU_CAP_PCI_ATS_NOT_SUPPORTED,
> };
>
> /* These are the possible reserved region types */
>diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>index 81c4d7733872..aa4399b6b6db 100644
>--- a/drivers/iommu/amd/iommu.c
>+++ b/drivers/iommu/amd/iommu.c
>@@ -2985,6 +2985,12 @@ static bool amd_iommu_capable(struct device *dev, enum iommu_cap cap)
>
> 		return amd_iommu_hd_support(iommu);
> 	}
>+	case IOMMU_CAP_PCI_ATS_NOT_SUPPORTED: {
>+		struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>+
>+		return !(amd_iommu_iotlb_sup &&
>+			 (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_ATS_SUP));
>+	}
> 	default:
> 		break;
> 	}
>diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>index 4d00d796f078..c20d2454ca14 100644
>--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>@@ -107,6 +107,7 @@ static const char * const event_class_str[] = {
> };
>
> static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
>+static bool arm_smmu_ats_supported(struct arm_smmu_master *master);
>
> static void parse_driver_options(struct arm_smmu_device *smmu)
> {
>@@ -2494,6 +2495,8 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
> 		return true;
> 	case IOMMU_CAP_DIRTY_TRACKING:
> 		return arm_smmu_dbm_capable(master->smmu);
>+	case IOMMU_CAP_PCI_ATS_NOT_SUPPORTED:
>+		return !arm_smmu_ats_supported(master);
> 	default:
> 		return false;
> 	}
>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>index ef7613b177b9..0be69695e88a 100644
>--- a/drivers/iommu/intel/iommu.c
>+++ b/drivers/iommu/intel/iommu.c
>@@ -3220,6 +3220,8 @@ static bool intel_iommu_capable(struct device *dev, enum iommu_cap cap)
> 		return ecap_sc_support(info->iommu->ecap);
> 	case IOMMU_CAP_DIRTY_TRACKING:
> 		return ssads_supported(info->iommu);
>+	case IOMMU_CAP_PCI_ATS_NOT_SUPPORTED:
>+		return !info->ats_supported;
> 	default:
> 		return false;
> 	}
>-- 
>2.43.0
>
>

Thanks,
Sami

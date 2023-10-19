Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAA4156F6
	for <iommu@lists.linux.dev>; Thu, 19 Oct 2023 08:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HebX7U/C"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J7smsm003172;
	Thu, 19 Oct 2023 08:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2vKU8FvHtK6L+y3XFDTt5+LChoDeKHjA7i1pZUHRUMw=;
 b=HebX7U/CJipiaRz0KdjUlmRZ7HcNshhGRc6m8S6XIFn+OB+P9sgFHPa+Kk8vi2BsJjU7
 iu4gaU27D9tDtPLdWD9nFPJGlaxhpvDXnHJtdfqsiR6Br8z5c03fy9/SuFPc58m15EgX
 mSaqd+Gh7AhfUECJ1bFsp3iJFrBjcIfsHJoU8+dcqGTBza5FP53nOg09Hq3enFAbvaTf
 rIT4UsGLm621SIgUXXMKZ9AlSPnZQ8V2rs3UB/uTZ0dpXcjp7rbAkD42Y/YdqA+TWJa+
 QrFca02htJmAZkwjf27cfxQYnLG9HDXS5gVMeimypOnxuLidqvSz3Hi2YAFf/35JaOO/ ew== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tt905b80a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Oct 2023 08:21:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39J8LpZ1031273
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Oct 2023 08:21:52 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 19 Oct
 2023 01:21:49 -0700
Message-ID: <0d6b490d-83df-76fb-f5ad-e9730fc57660@quicinc.com>
Date: Thu, 19 Oct 2023 16:21:47 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [ARM IOMMU] IOMMU framework concurrency issue
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>
CC: <will@kernel.org>, <joro@8bytes.org>, <baolu.lu@linux.intel.com>,
        <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <quic_tingweiz@quicinc.com>, Pavan Kondeti <quic_pkondeti@quicinc.com>,
        "Patrick Daly (QUIC)" <quic_pdaly@quicinc.com>
References: <e2e20e1c-6450-4ac5-9804-b0000acdf7de@quicinc.com>
 <20231017163337.GE282036@ziepe.ca>
 <70cc8d3d-1ddf-4700-ac15-bcd74fae2b2a@arm.com>
 <20231018161918.GB691768@ziepe.ca>
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <20231018161918.GB691768@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 28IrGAJMP5jVQMQci_NCUe4SuTbjD80Y
X-Proofpoint-ORIG-GUID: 28IrGAJMP5jVQMQci_NCUe4SuTbjD80Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_05,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190069



On 2023/10/19 0:19, Jason Gunthorpe wrote:
> On Wed, Oct 18, 2023 at 04:34:20PM +0100, Robin Murphy wrote:
>> On 2023-10-17 17:33, Jason Gunthorpe wrote:
>>>
>>> eg make sure the iommu driver is fully registered before allowing any
>>> concurrent probes. Once the iommu driver is registered it will be able
>>> to catch the bus notifiers and serialize things properly.
>>
>> Ugh, I think I see at least how this happens for device which *don't* have
>> an IOMMU - because iommu_init_device() has to transiently allocate
>> dev->iommu in order to call ops->probe_device in order to discover
>> that the
> 
> Hmm! Is it essential though? That ordering was C&P from before, I
> didn't study it closely when I copied it..
> 
> I only checked some drivers, but something like this looked like it
> could resolve the situation you described - Zhenhua is that your
> situation, a non-probed device?

Thanks Jason and Robin.
Typo? you mean non-iommu device? Yes, it happens also for non-iommu 
device. In separated email I listed this situation:

Client device's probing:
of_iommu_configure  ---Thread 1
     struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
     if (fwspec) {
          if (fwspec->ops)
             ...

IOMMU probing:
iommu_device_register ---Thread 2
     .. bus_iommu_probe(iommu_buses[i]);
         __iommu_probe_device
             iommu_init_device
                 dev_iommu_get
                 ... *time window of concurrency*  ------(1)
                 dev_iommu_free

In above time window (1), dev->iommu allocated but not freed, if it's 
just accessed by client device's probing(Thread 1)..     crash happens.

I also want to mention from our side, it's *not only seen for non-iommu* 
device.

Patch seems good to me and in theory can cover the case I have met. I 
tested below based on 6.6-rc1 for sanity with minor changes(clean up 
tags etc). If you're OK I want to propagate into our tree and to see if 
it fixes issue?

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3bfc56d..3a207f3 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -381,6 +381,16 @@ static u32 dev_iommu_get_max_pasids(struct device *dev)
         return min_t(u32, max_pasids, dev->iommu->iommu_dev->max_pasids);
  }

+void dev_iommu_priv_set(struct device *dev, void *priv)
+{
+       struct dev_iommu *dev_iommu;
+
+       dev_iommu = dev_iommu_get(dev);
+       if (WARN_ON(!dev_iommu))
+               return; // FIXME handle failure in drivers
+       dev->iommu->priv = priv;
+}
+
  /*
   * Init the dev->iommu and dev->iommu_group in the struct device and 
get the
   * driver probed
@@ -388,16 +398,12 @@ static u32 dev_iommu_get_max_pasids(struct device 
*dev)
  static int iommu_init_device(struct device *dev, const struct 
iommu_ops *ops)
  {
         struct iommu_device *iommu_dev;
+       struct dev_iommu *dev_iommu;
         struct iommu_group *group;
         int ret;
-       if (!dev_iommu_get(dev))
-               return -ENOMEM;
-
-       if (!try_module_get(ops->owner)) {
-               ret = -EINVAL;
-               goto err_free;
-       }
+       if (!try_module_get(ops->owner))
+               return -EINVAL;

         iommu_dev = ops->probe_device(dev);
         if (IS_ERR(iommu_dev)) {
@@ -405,6 +411,14 @@ static int iommu_init_device(struct device *dev, 
const struct iommu_ops *ops)
                 goto err_module_put;
         }

+       dev_iommu = dev_iommu_get(dev);
+       if (WARN_ON(!dev_iommu)) {
+               ret = -ENOMEM;
+               goto err_release;
+       }
+
+       dev_iommu->iommu_dev = iommu_dev;
+
         ret = iommu_device_link(iommu_dev, dev);
         if (ret)
                 goto err_release;
@@ -418,10 +432,9 @@ static int iommu_init_device(struct device *dev, 
const struct iommu_ops *ops)
         }
         dev->iommu_group = group;

-       dev->iommu->iommu_dev = iommu_dev;
-       dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
+       dev_iommu->max_pasids = dev_iommu_get_max_pasids(dev);
         if (ops->is_attach_deferred)
-               dev->iommu->attach_deferred = ops->is_attach_deferred(dev);
+               dev_iommu->attach_deferred = ops->is_attach_deferred(dev);
         return 0;

  err_unlink:
@@ -431,8 +444,11 @@ static int iommu_init_device(struct device *dev, 
const struct iommu_ops *ops)
                 ops->release_device(dev);
  err_module_put:
         module_put(ops->owner);
-err_free:
-       dev_iommu_free(dev);
+       /*
+        * If probe_device allocated a dev->iommu and things failed later
+        * we just leave it. We don't yet have robust locking, there
+        * could be concurrent users.
+        */
         return ret;
  }

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c50a769..21c15be 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -698,10 +698,7 @@ static inline void *dev_iommu_priv_get(struct 
device *dev)
                 return NULL;
  }

-static inline void dev_iommu_priv_set(struct device *dev, void *priv)
-{
-       dev->iommu->priv = priv;
-}
+void dev_iommu_priv_set(struct device *dev, void *priv);

  int iommu_probe_device(struct device *dev);

Thanks,
Zhenhua

> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 47172f1084d8fd..580e74afdb0765 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -386,6 +386,16 @@ static u32 dev_iommu_get_max_pasids(struct device *dev)
>   	return min_t(u32, max_pasids, dev->iommu->iommu_dev->max_pasids);
>   }
>   
> +void dev_iommu_priv_set(struct device *dev, void *priv)
> +{
> +	struct dev_iommu *dev_iommu;
> +
> +	dev_iommu = dev_iommu_get(dev);
> +	if (WARN_ON(!dev_iommu))
> +		return; // FIXME handle failure in drivers
> +	dev->iommu->priv = priv;
> +}
> +
>   /*
>    * Init the dev->iommu and dev->iommu_group in the struct device and get the
>    * driver probed
> @@ -393,12 +403,10 @@ static u32 dev_iommu_get_max_pasids(struct device *dev)
>   static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
>   {
>   	struct iommu_device *iommu_dev;
> +	struct dev_iommu *dev_iommu;
>   	struct iommu_group *group;
>   	int ret;
>   
> -	if (!dev_iommu_get(dev))
> -		return -ENOMEM;
> -
>   	if (!try_module_get(ops->owner)) {
>   		ret = -EINVAL;
>   		goto err_free;
> @@ -409,7 +417,14 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
>   		ret = PTR_ERR(iommu_dev);
>   		goto err_module_put;
>   	}
> -	dev->iommu->iommu_dev = iommu_dev;
> +
> +	dev_iommu = dev_iommu_get(dev);
> +	if (WARN_ON(!dev_iommu)) {
> +		ret = -ENOMEM;
> +		goto err_release;
> +	}
> +
> +	dev_iommu->iommu_dev = iommu_dev;
>   
>   	ret = iommu_device_link(iommu_dev, dev);
>   	if (ret)
> @@ -424,9 +439,9 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
>   	}
>   	dev->iommu_group = group;
>   
> -	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
> +	dev_iommu->max_pasids = dev_iommu_get_max_pasids(dev);
>   	if (ops->is_attach_deferred)
> -		dev->iommu->attach_deferred = ops->is_attach_deferred(dev);
> +		dev_iommu->attach_deferred = ops->is_attach_deferred(dev);
>   	return 0;
>   
>   err_unlink:
> @@ -438,7 +453,11 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
>   	module_put(ops->owner);
>   err_free:
>   	dev->iommu->iommu_dev = NULL;
> -	dev_iommu_free(dev);
> +	/*
> +	 * If probe_device allocated a dev->iommu and things failed later
> +	 * we just leave it. We don't yet have robust locking, there
> +	 * could be concurrent users.
> +	 */
>   	return ret;
>   }
>   
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 68c9be9293e4c0..5c25c378a13ece 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -713,10 +713,7 @@ static inline void *dev_iommu_priv_get(struct device *dev)
>   		return NULL;
>   }
>   
> -static inline void dev_iommu_priv_set(struct device *dev, void *priv)
> -{
> -	dev->iommu->priv = priv;
> -}
> +void dev_iommu_priv_set(struct device *dev, void *priv);
>   
>   int iommu_probe_device(struct device *dev);
>   

From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 0/6] Add platform device SVM support for ARM SMMUv3
Date: Thu, 7 Sep 2017 17:32:13 +0100
Message-ID: <bde256dd-6550-6c40-fe2c-2bd1cc1339d3@arm.com>
References: <1504167642-14922-1-git-send-email-xieyisheng1@huawei.com>
 <95d1a9e2-1816-ff7d-9a8d-98406a6c2c22@arm.com>
 <caf68193-6aff-1e1c-86cd-9cc7069b0e37@huawei.com>
 <2874a1f3-22f1-20d4-4009-50add127a10f@arm.com>
 <1d358989-48bb-ccde-d7d9-36e004bc2d78@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1d358989-48bb-ccde-d7d9-36e004bc2d78-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bob Liu <liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Yisheng Xie <xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, chenjiankang1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, xieyisheng-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 07/09/17 02:41, Bob Liu wrote:
>> This would require some work in moving the PCI bits at the end of the
>> series. I can reserve some time in the coming months to do it, but I need
>> to know what to focus on. Are you able to test SSID as well?
>>
> 
> Yes, but the difficulty is our devices are on-chip integrated hardware accelerators which requires complicate driver.
> You may need much time to understand the driver.
> That's the same case as intel/amd SVM, the current user is their GPU :-(
> 
> Btw, what kind of device/method do you think is ideal for testing arm-SVM?

A simple, bare DMA engine would be ideal. Something just capable of
performing memcpy with parameters (PASID, input IOVA, output IOVA, size)
can be used for validating SVM and virtualization. You could easily create
reproducible unit tests and userspace drivers. If it supports isolated
channels (as in SR-IOV), even better.

As you said, having a useful device like a full GPU/accelerator as opposed
to a dummy validation engine makes it difficult to fully test the SMMU.
However it can be helpful for evaluating driver performances and is still
good enough for confirming that the IOMMU works.

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

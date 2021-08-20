Return-Path: <SRS0=ckUw=NL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F13C4320A
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 15:20:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C47CF6113B
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 15:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C47CF6113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9218B60712;
	Fri, 20 Aug 2021 15:20:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F0EBZk5pwkAt; Fri, 20 Aug 2021 15:20:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 627CD605DC;
	Fri, 20 Aug 2021 15:20:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3921AC001A;
	Fri, 20 Aug 2021 15:20:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5AAA8C000E
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 15:20:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 48ABD605E8
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 15:20:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AG1HbiZNZt1x for <iommu@lists.linux-foundation.org>;
 Fri, 20 Aug 2021 15:20:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 540C1605DC
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 15:20:37 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id g14so8879482pfm.1
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 08:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lOEOP553DOa54mvzQOTvxqghJgRlAqL/9egTYk51TpA=;
 b=mNTS2gd5G3Ks7sZBiQSqKbxnuIVyWXDolh/tFasaTIp9Tx741ulpCEBBJUeNG6CWbn
 bJhOlYcTmBgVknfCmejlU0pKjFYMNkb+mTQ+mEeg9ITv0adYOUR3hmKmVoC7BoPnsD0I
 XWSBpp9HDsxPIU9RwnpnjWs+5qzfOYMAlk5vuGurnNnqnw7ijhJHg8X5IJWWxqYixCt3
 +tg+SVuZQBaKBNS55ZDk0TnfxHeHQGNWLe/31oj8sgUHgNeRZB8TZc9b01CQkJiBbfS1
 6m4md9Xn57tauA6eGKdWIXay7jb4zj040dBBFUXZl5hvlW19Wrja0c672M7277VVHF2w
 s3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lOEOP553DOa54mvzQOTvxqghJgRlAqL/9egTYk51TpA=;
 b=k1LQ3xs7wvOb+U57mgJu0LYk81cInmyaLiqZIDBRjP98ijGg92C9AzCp2EXfoNNbXi
 iO9y971uEjSFJSO1XTLxjF2VmBzJ52BEo1dV9InQ8i9O6cYlSwMmOfy2VbEH0RTdnI3J
 vmp8JJCjcS/7FG1pghF/vOPn8EolIBOQdFIBP0VvGE3AiDmvRT7vyMa/BE9jO/qm7cF5
 h0LV9nWD5wji+ll6KF8TOMUnuotjrRwqajnMnE3J4O/ermZejN4hsqYB7cmNrMjG4IQ9
 oV+Qdupm6d3Q/b8HGOouUSSn352ewHfHgeR8P/n2QEQmpsl7peNP/8nsG9P1IwhUBecX
 ETQg==
X-Gm-Message-State: AOAM531AN8hfSrZGiyxPij/mUtEEFw/rZYOLvTWn8S8rTniv9p84sSbB
 6tLJevlOLiiHXIsDWgM5J34=
X-Google-Smtp-Source: ABdhPJzI2VZH5dwiRm0Ac/QtnJrMRH7ImkxlvumANqaLggfhogz2MaNnTDbHOsxuG4eIDNmSXl+big==
X-Received: by 2002:aa7:9f12:0:b029:3e0:3224:6cd5 with SMTP id
 g18-20020aa79f120000b02903e032246cd5mr20286867pfr.43.1629472836712; 
 Fri, 20 Aug 2021 08:20:36 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::50b? ([2404:f801:9000:18:efec::50b])
 by smtp.gmail.com with ESMTPSA id
 j5sm12049220pjv.56.2021.08.20.08.20.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Aug 2021 08:20:36 -0700 (PDT)
Subject: Re: [PATCH V3 13/13] HV/Storvsc: Add Isolation VM support for storvsc
 driver
To: Michael Kelley <mikelley@microsoft.com>, KY Srinivasan
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "luto@kernel.org" <luto@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "jgross@suse.com" <jgross@suse.com>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "jejb@linux.ibm.com"
 <jejb@linux.ibm.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 "ardb@kernel.org" <ardb@kernel.org>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "pgonda@google.com" <pgonda@google.com>,
 "martin.b.radev@gmail.com" <martin.b.radev@gmail.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "rppt@kernel.org" <rppt@kernel.org>,
 "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "saravanand@fb.com" <saravanand@fb.com>,
 "krish.sadhukhan@oracle.com" <krish.sadhukhan@oracle.com>,
 "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "rientjes@google.com" <rientjes@google.com>,
 "hannes@cmpxchg.org" <hannes@cmpxchg.org>, "tj@kernel.org" <tj@kernel.org>
References: <20210809175620.720923-1-ltykernel@gmail.com>
 <20210809175620.720923-14-ltykernel@gmail.com>
 <MWHPR21MB1593EEF30FFD5C60ED744985D7C09@MWHPR21MB1593.namprd21.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <a96626db-4ac9-3ce4-64e9-92568e4f827a@gmail.com>
Date: Fri, 20 Aug 2021 23:20:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB1593EEF30FFD5C60ED744985D7C09@MWHPR21MB1593.namprd21.prod.outlook.com>
Content-Language: en-US
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dave.hansen@intel.com" <dave.hansen@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 vkuznets <vkuznets@redhat.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 8/20/2021 2:17 AM, Michael Kelley wrote:
> From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, August 9, 2021 10:56 AM
>>
> 
> Subject line tag should be "scsi: storvsc:"
> 
>> In Isolation VM, all shared memory with host needs to mark visible
>> to host via hvcall. vmbus_establish_gpadl() has already done it for
>> storvsc rx/tx ring buffer. The page buffer used by vmbus_sendpacket_
>> mpb_desc() still need to handle. Use DMA API to map/umap these
> 
> s/need to handle/needs to be handled/
> 
>> memory during sending/receiving packet and Hyper-V DMA ops callback
>> will use swiotlb function to allocate bounce buffer and copy data
>> from/to bounce buffer.
>>
>> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> ---
>>   drivers/scsi/storvsc_drv.c | 68 +++++++++++++++++++++++++++++++++++---
>>   1 file changed, 63 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
>> index 328bb961c281..78320719bdd8 100644
>> --- a/drivers/scsi/storvsc_drv.c
>> +++ b/drivers/scsi/storvsc_drv.c
>> @@ -21,6 +21,8 @@
>>   #include <linux/device.h>
>>   #include <linux/hyperv.h>
>>   #include <linux/blkdev.h>
>> +#include <linux/io.h>
>> +#include <linux/dma-mapping.h>
>>   #include <scsi/scsi.h>
>>   #include <scsi/scsi_cmnd.h>
>>   #include <scsi/scsi_host.h>
>> @@ -427,6 +429,8 @@ struct storvsc_cmd_request {
>>   	u32 payload_sz;
>>
>>   	struct vstor_packet vstor_packet;
>> +	u32 hvpg_count;
> 
> This count is really the number of entries in the dma_range
> array, right?  If so, perhaps "dma_range_count" would be
> a better name so that it is more tightly associated.

Yes, will update.

> 
>> +	struct hv_dma_range *dma_range;
>>   };
>>
>>
>> @@ -509,6 +513,14 @@ struct storvsc_scan_work {
>>   	u8 tgt_id;
>>   };
>>
>> +#define storvsc_dma_map(dev, page, offset, size, dir) \
>> +	dma_map_page(dev, page, offset, size, dir)
>> +
>> +#define storvsc_dma_unmap(dev, dma_range, dir)		\
>> +		dma_unmap_page(dev, dma_range.dma,	\
>> +			       dma_range.mapping_size,	\
>> +			       dir ? DMA_FROM_DEVICE : DMA_TO_DEVICE)
>> +
> 
> Each of these macros is used only once.  IMHO, they don't
> add a lot of value.  Just coding dma_map/unmap_page()
> inline would be fine and eliminate these lines of code.

OK. Will update.

> 
>>   static void storvsc_device_scan(struct work_struct *work)
>>   {
>>   	struct storvsc_scan_work *wrk;
>> @@ -1260,6 +1272,7 @@ static void storvsc_on_channel_callback(void *context)
>>   	struct hv_device *device;
>>   	struct storvsc_device *stor_device;
>>   	struct Scsi_Host *shost;
>> +	int i;
>>
>>   	if (channel->primary_channel != NULL)
>>   		device = channel->primary_channel->device_obj;
>> @@ -1314,6 +1327,15 @@ static void storvsc_on_channel_callback(void *context)
>>   				request = (struct storvsc_cmd_request *)scsi_cmd_priv(scmnd);
>>   			}
>>
>> +			if (request->dma_range) {
>> +				for (i = 0; i < request->hvpg_count; i++)
>> +					storvsc_dma_unmap(&device->device,
>> +						request->dma_range[i],
>> +						request->vstor_packet.vm_srb.data_in == READ_TYPE);
> 
> I think you can directly get the DMA direction as request->cmd->sc_data_direction.
> 
>> +
>> +				kfree(request->dma_range);
>> +			}
>> +
>>   			storvsc_on_receive(stor_device, packet, request);
>>   			continue;
>>   		}
>> @@ -1810,7 +1832,9 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
>>   		unsigned int hvpgoff, hvpfns_to_add;
>>   		unsigned long offset_in_hvpg = offset_in_hvpage(sgl->offset);
>>   		unsigned int hvpg_count = HVPFN_UP(offset_in_hvpg + length);
>> +		dma_addr_t dma;
>>   		u64 hvpfn;
>> +		u32 size;
>>
>>   		if (hvpg_count > MAX_PAGE_BUFFER_COUNT) {
>>
>> @@ -1824,6 +1848,13 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
>>   		payload->range.len = length;
>>   		payload->range.offset = offset_in_hvpg;
>>
>> +		cmd_request->dma_range = kcalloc(hvpg_count,
>> +				 sizeof(*cmd_request->dma_range),
>> +				 GFP_ATOMIC);
> 
> With this patch, it appears that storvsc_queuecommand() is always
> doing bounce buffering, even when running in a non-isolated VM.

In the non-isolated VM, SWIOTLB_FORCE mode isn't enabled and so
the swiotlb bounce buffer will not work.

> The dma_range is always allocated, and the inner loop below does
> the dma mapping for every I/O page.  The corresponding code in
> storvsc_on_channel_callback() that does the dma unmap allows for
> the dma_range to be NULL, but that never happens.

Yes, dma mapping function will return PA directly in non-isolated VM.

> 
>> +		if (!cmd_request->dma_range) {
>> +			ret = -ENOMEM;
> 
> The other memory allocation failure in this function returns
> SCSI_MLQUEUE_DEVICE_BUSY.   It may be debatable as to whether
> that's the best approach, but that's a topic for a different patch.  I
> would suggest being consistent and using the same return code
> here.

OK. I will keep to return SCSI_MLQUEUE_DEVICE_BUSY here.

> 
>> +			goto free_payload;
>> +		}
>>
>>   		for (i = 0; sgl != NULL; sgl = sg_next(sgl)) {
>>   			/*
>> @@ -1847,9 +1878,29 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
>>   			 * last sgl should be reached at the same time that
>>   			 * the PFN array is filled.
>>   			 */
>> -			while (hvpfns_to_add--)
>> -				payload->range.pfn_array[i++] =	hvpfn++;
>> +			while (hvpfns_to_add--) {
>> +				size = min(HV_HYP_PAGE_SIZE - offset_in_hvpg,
>> +					   (unsigned long)length);
>> +				dma = storvsc_dma_map(&dev->device, pfn_to_page(hvpfn++),
>> +						      offset_in_hvpg, size,
>> +						      scmnd->sc_data_direction);
>> +				if (dma_mapping_error(&dev->device, dma)) {
>> +					ret = -ENOMEM;
> 
> The typical error from dma_map_page() will be running out of
> bounce buffer memory.   This is a transient condition that should be
> retried at the higher levels.  So make sure to return an error code
> that indicates the I/O should be resubmitted.

OK. It looks like error code should be SCSI_MLQUEUE_DEVICE_BUSY here.

> 
>> +					goto free_dma_range;
>> +				}
>> +
>> +				if (offset_in_hvpg) {
>> +					payload->range.offset = dma & ~HV_HYP_PAGE_MASK;
>> +					offset_in_hvpg = 0;
>> +				}
> 
> I'm not clear on why payload->range.offset needs to be set again.
> Even after the dma mapping is done, doesn't the offset in the first
> page have to be the same?  If it wasn't the same, Hyper-V wouldn't
> be able to process the PFN list correctly.  In fact, couldn't the above
> code just always set offset_in_hvpg = 0?

The offset will be changed. The swiotlb bounce buffer is allocated with 
IO_TLB_SIZE(2K) as unit. So the offset here may be changed.

> 
>> +
>> +				cmd_request->dma_range[i].dma = dma;
>> +				cmd_request->dma_range[i].mapping_size = size;
>> +				payload->range.pfn_array[i++] = dma >> HV_HYP_PAGE_SHIFT;
>> +				length -= size;
>> +			}
>>   		}
>> +		cmd_request->hvpg_count = hvpg_count;
> 
> This line just saves the size of the dma_range array.  Could
> it be moved up with the code that allocates the dma_range
> array?  To me, it would make more sense to have all that
> code together in one place.

Sure. Will update.

> 
>>   	}
> 
> The whole approach here is to do dma remapping on each individual page
> of the I/O buffer.  But wouldn't it be possible to use dma_map_sg() to map
> each scatterlist entry as a unit?  Each scatterlist entry describes a range of
> physically contiguous memory.  After dma_map_sg(), the resulting dma
> address must also refer to a physically contiguous range in the swiotlb
> bounce buffer memory.   So at the top of the "for" loop over the scatterlist
> entries, do dma_map_sg() if we're in an isolated VM.  Then compute the
> hvpfn value based on the dma address instead of sg_page().  But everything
> else is the same, and the inner loop for populating the pfn_arry is unmodified.
> Furthermore, the dma_range array that you've added is not needed, since
> scatterlist entries already have a dma_address field for saving the mapped
> address, and dma_unmap_sg() uses that field.

I don't use dma_map_sg() here in order to avoid introducing one more 
loop(e,g dma_map_sg()). We already have a loop to populate 
cmd_request->dma_range[] and so do the dma map in the same loop.

> 
> One thing:  There's a maximum swiotlb mapping size, which I think works
> out to be 256 Kbytes.  See swiotlb_max_mapping_size().  We need to make
> sure that we don't get a scatterlist entry bigger than this size.  But I think
> this already happens because you set the device->dma_mask field in
> Patch 11 of this series.  __scsi_init_queue checks for this setting and
> sets max_sectors to limits transfers to the max mapping size.

I will double check.

> 
>>
>>   	cmd_request->payload = payload;
>> @@ -1860,13 +1911,20 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
>>   	put_cpu();
>>
>>   	if (ret == -EAGAIN) {
>> -		if (payload_sz > sizeof(cmd_request->mpb))
>> -			kfree(payload);
>>   		/* no more space */
>> -		return SCSI_MLQUEUE_DEVICE_BUSY;
>> +		ret = SCSI_MLQUEUE_DEVICE_BUSY;
>> +		goto free_dma_range;
>>   	}
>>
>>   	return 0;
>> +
>> +free_dma_range:
>> +	kfree(cmd_request->dma_range);
>> +
>> +free_payload:
>> +	if (payload_sz > sizeof(cmd_request->mpb))
>> +		kfree(payload);
>> +	return ret;
>>   }
>>
>>   static struct scsi_host_template scsi_driver = {
>> --
>> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

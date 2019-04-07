Return-Path: <SRS0=ZMNw=SJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6E9C10F0E
	for <iommu@archiver.kernel.org>; Sun,  7 Apr 2019 23:02:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE79F20863
	for <iommu@archiver.kernel.org>; Sun,  7 Apr 2019 23:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE79F20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6C118941;
	Sun,  7 Apr 2019 23:02:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 258727F6
	for <iommu@lists.linux-foundation.org>;
	Sun,  7 Apr 2019 23:02:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
	[209.85.210.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BF82F63D
	for <iommu@lists.linux-foundation.org>;
	Sun,  7 Apr 2019 23:02:34 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id t21so4149228pfh.2
	for <iommu@lists.linux-foundation.org>;
	Sun, 07 Apr 2019 16:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=9zlgt+mXmo5BIlOtSBEORdXIcBr+Qz5XdRzca4ZOr6M=;
	b=Oe4uQ9gN+kbhxVTRoeeindBv0x1wHI37x124fi16/D6v2LZ669PW+bzCwKZE8Hivpc
	wh8OybatknSgfixv8Lx3Uf541b2ONE/ZDfNhLnG3rEmupEOvxMsgi9yKLtHDA1gnWAOp
	yb9eG1CPBDLOig1tqRmAiMI7VxYRFLPohREGlqH1IfFUp+qXBRgS7IktiemcqKMcsaKJ
	U+pDHjUuGIjWF4RG+bXO626tWNuMgL6nyKozc8EdoxEjd6w+meJQZ9DY9AYRsOldI8uA
	U1HZqOAnBlrdCcykhsYUsy+kXZKhvYZiIgOaCTj+dav3YN8QXArqTfglOh3kEWB+cUrE
	HRgg==
X-Gm-Message-State: APjAAAWoRrqfqTTZHwjrAUtdlSaQswsU40DV4a4c9WXjc7pVVPbslrLx
	7BYxlYLJQQciQpuYI66JmTY=
X-Google-Smtp-Source: APXvYqyqLyd6VqFSzOamKfvcs0Ynfu7QHhyXLLC8hAtLvmyEbloOcK+HGhtcXgWYI+Km5vyHyRIs9w==
X-Received: by 2002:a62:7591:: with SMTP id q139mr12542988pfc.14.1554678154073;
	Sun, 07 Apr 2019 16:02:34 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
	by smtp.gmail.com with ESMTPSA id
	b14sm40609012pfi.92.2019.04.07.16.02.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 07 Apr 2019 16:02:32 -0700 (PDT)
Subject: Re: kernel BUG at drivers/iommu/intel-iommu.c:608
To: Alex Williamson <alex.williamson@redhat.com>
References: <a523ea10-3dab-fa2c-1ecf-5cf32077565f@acm.org>
	<20190407150650.060cc508@x1.home>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <8d876549-21da-e027-0157-8737b10e26f8@acm.org>
Date: Sun, 7 Apr 2019 16:02:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190407150650.060cc508@x1.home>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
	Jiang Liu <jiang.liu@linux.intel.com>, James Smart <jsmart2021@gmail.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190407230231.g-wVmbMt1UOFrMJbHuYhOVPrun3Z0zl0s3wj0cahZMI@z>

On 4/7/19 2:06 PM, Alex Williamson wrote:
> On Sun, 7 Apr 2019 12:10:38 -0700
> Bart Van Assche <bvanassche@acm.org> wrote:
>> If I tell qemu to use PCI pass-through for a PCI adapter and next load the
>> lpfc driver for an lpfc adapter that has not been passed through to any VM
>> a kernel bug is hit. Do you perhaps know whether it should be possible to
>> a load kernel driver in this scenario? If so, do you know what should change
>> to avoid that this kernel bug is hit? Should the iommu code be modified or
>> should the lpfc code be modified? I'm asking you because I think that you
>> introduced the BUG() statement that was hit. See also commit ab8dfe251571
>> ("iommu/vt-d: Introduce helper functions to improve code readability"; v3.17).
> 
> Do both of these lpfc devices belong to the same IOMMU group?
> (/sys/kernel/iommu_groups/)  Thanks,

Hi Alex,

Apparently the two Emulex (lpfc) and the two QLogic ports are in the same IOMMU group:

# lspci | grep -E 'QLogic|Emulex'
01:00.0 Fibre Channel: Emulex Corporation Lancer Gen6: LPe32000 Fibre Channel Host Adapter (rev 01)
01:00.1 Fibre Channel: Emulex Corporation Lancer Gen6: LPe32000 Fibre Channel Host Adapter (rev 01)
02:00.0 Fibre Channel: QLogic Corp. ISP2532-based 8Gb Fibre Channel to PCI Express HBA (rev 02)
02:00.1 Fibre Channel: QLogic Corp. ISP2532-based 8Gb Fibre Channel to PCI Express HBA (rev 02)

# ls -d /sys/kernel/iommu_groups/*/devices/0000:0[12]:00.*
/sys/kernel/iommu_groups/1/devices/0000:01:00.0
/sys/kernel/iommu_groups/1/devices/0000:01:00.1
/sys/kernel/iommu_groups/1/devices/0000:02:00.0
/sys/kernel/iommu_groups/1/devices/0000:02:00.1

Thanks,

Bart.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

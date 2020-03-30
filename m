Return-Path: <SRS0=6vqp=5Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE30AC43331
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 04:26:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6DE220748
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 04:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S05WgtKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6DE220748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7154985FF3;
	Tue, 31 Mar 2020 04:26:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LfPCSBBZh9lP; Tue, 31 Mar 2020 04:26:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8905685B12;
	Tue, 31 Mar 2020 04:26:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DB88C1D7E;
	Tue, 31 Mar 2020 04:26:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 849BDC07FF
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 23:37:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6FA3386A9D
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 23:37:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sErmEA4ib6cg for <iommu@lists.linux-foundation.org>;
 Mon, 30 Mar 2020 23:37:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9B3E186A8C
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 23:37:40 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02UNNTCo175413;
 Mon, 30 Mar 2020 23:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=62p3SqIkPRrTrUQUrnww+150K3Afb4y1vUHtmaHqJDQ=;
 b=S05WgtKNcniGTGoZkZru+F83SF9x+zQgMHlTW8JThcP3UculkmgVkB//MqH/IBuWIsgW
 AhvBqYz5MHQCQLscQocRDwwiIkNDwkXINYYY2riJ6eZ3/PP97vOTrldIal4xgC3zF89E
 Zys5ZHZcEKgpLdq0S0iYvF/HConRjWReUyWEo5M5RVM0lGv01utFD8VLCwsVyXf9MDxO
 vpxkbiJqfQcHYYnZ/2b/TIbva1oeAamBfPdTzW7V6uUMdP5rSSkaTrBH2qkOYm0kuKws
 e8ET8Gln4lknR4zOGV8HsOacIJ61Pu0YmcbKeHTgWdEYGM6FlH7eF8RNA3LJZqCF24as xQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 301xhkss0g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Mar 2020 23:37:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02UNMIM5174852;
 Mon, 30 Mar 2020 23:37:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 302g4qhm1t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Mar 2020 23:37:24 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02UNbKmi008947;
 Mon, 30 Mar 2020 23:37:20 GMT
Received: from [10.154.136.252] (/10.154.136.252)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 30 Mar 2020 16:37:20 -0700
Subject: Re: [PATCH] swiotlb: Allow swiotlb to live at pre-defined address
To: Alexander Graf <graf@amazon.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Kairui Song <kasong@redhat.com>,
 Jan Setje-Eilers <jan.setjeeilers@oracle.com>
References: <20200326162922.27085-1-graf@amazon.com>
 <20200328115733.GA67084@dhcp-128-65.nay.redhat.com>
 <CACPcB9d_Pz9SRhSsRzqygRR6waV7r8MnGcCP952svnZtpFaxnQ@mail.gmail.com>
 <20200330134004.GA31026@char.us.oracle.com>
 <51432837-8804-0600-c7a3-8849506f999e@amazon.com>
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Organization: Oracle Corporation
Message-ID: <5dd6e987-8867-9fb8-386a-f86bbe0828e8@oracle.com>
Date: Mon, 30 Mar 2020 16:37:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <51432837-8804-0600-c7a3-8849506f999e@amazon.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9576
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003300192
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9576
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 mlxscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 clxscore=1011 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003300192
X-Mailman-Approved-At: Tue, 31 Mar 2020 04:26:09 +0000
Cc: Mark Rutland <mark.rutland@arm.com>, brijesh.singh@amd.com,
 Lianbo Jiang <lijiang@redhat.com>, linux-doc@vger.kernel.org,
 Jan Kiszka <jan.kiszka@siemens.com>, "Schoenherr, Jan H." <jschoenh@amazon.de>,
 Christoph Hellwig <hch@lst.de>, the arch/x86 maintainers <x86@kernel.org>,
 Laszlo Ersek <lersek@redhat.com>, aggh@amazon.com, "Lendacky,
 Thomas" <thomas.lendacky@amd.com>, alcioa@amazon.com, dhr@amazon.com,
 benh@amazon.com, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, aagch@amazon.com,
 Robin Murphy <robin.murphy@arm.com>, dwmw@amazon.com
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 3/30/20 1:42 PM, Alexander Graf wrote:
>
>
> On 30.03.20 15:40, Konrad Rzeszutek Wilk wrote:
>>
>>
>>
>> On Mon, Mar 30, 2020 at 02:06:01PM +0800, Kairui Song wrote:
>>> On Sat, Mar 28, 2020 at 7:57 PM Dave Young <dyoung@redhat.com> wrote:
>>>>
>>>> On 03/26/20 at 05:29pm, Alexander Graf wrote:
>>>>> The swiotlb is a very convenient fallback mechanism for bounce buffer=
ing of
>>>>> DMAable data. It is usually used for the compatibility case where dev=
ices
>>>>> can only DMA to a "low region".
>>>>>
>>>>> However, in some scenarios this "low region" may be bound even more
>>>>> heavily. For example, there are embedded system where only an SRAM re=
gion
>>>>> is shared between device and CPU. There are also heterogeneous comput=
ing
>>>>> scenarios where only a subset of RAM is cache coherent between the
>>>>> components of the system. There are partitioning hypervisors, where
>>>>> a "control VM" that implements device emulation has limited view into=
 a
>>>>> partition's memory for DMA capabilities due to safety concerns.
>>>>>
>>>>> This patch adds a command line driven mechanism to move all DMA memor=
y into
>>>>> a predefined shared memory region which may or may not be part of the
>>>>> physical address layout of the Operating System.
>>>>>
>>>>> Ideally, the typical path to set this configuration would be through =
Device
>>>>> Tree or ACPI, but neither of the two mechanisms is standardized yet. =
Also,
>>>>> in the x86 MicroVM use case, we have neither ACPI nor Device Tree, but
>>>>> instead configure the system purely through kernel command line optio=
ns.
>>>>>
>>>>> I'm sure other people will find the functionality useful going forward
>>>>> though and extend it to be triggered by DT/ACPI in the future.
>>>>
>>>> Hmm, we have a use case for kdump, this maybe useful.=A0 For example
>>>> swiotlb is enabled by default if AMD SME/SEV is active, and in kdump
>>>> kernel we have to increase the crashkernel reserved size for the extra
>>>> swiotlb requirement.=A0 I wonder if we can just reuse the old kernel's
>>>> swiotlb region and pass the addr to kdump kernel.
>>>>
>>>
>>> Yes, definitely helpful for kdump kernel. This can help reduce the
>>> crashkernel value.
>>>
>>> Previously I was thinking about something similar, play around the
>>> e820 entry passed to kdump and let it place swiotlb in wanted region.
>>> Simply remap it like in this patch looks much cleaner.
>>>
>>> If this patch is acceptable, one more patch is needed to expose the
>>> swiotlb in iomem, so kexec-tools can pass the right kernel cmdline to
>>> second kernel.
>>
>> We seem to be passsing a lot of data to kexec.. Perhaps something
>> of a unified way since we seem to have a lot of things to pass - disabli=
ng
>> IOMMU, ACPI RSDT address, and then this.
>>
>> CC-ing Anthony who is working on something - would you by any chance
>> have a doc on this?
>
>
> I see in general 2 use cases here:
>
>
> 1) Allow for a generic mechanism to have the fully system, individual bus=
es, devices or functions of a device go through a particular, self-containe=
d bounce buffer.
>
> This sounds like the holy grail to a lot of problems. It would solve typi=
cal embedded scenarios where you only have a shared SRAM. It solves the saf=
ety case (to some extent) where you need to ensure that one device interact=
ion doesn't conflict with another device interaction. It also solves the pr=
oblem I've tried to solve with the patch here.
>
> It's unfortunately a lot harder than the patch I sent, so it will take me=
 some time to come up with a working patch set.. I suppose starting with a =
DT binding only is sensible. Worst case, x86 does also support DT ...
>
> (And yes, I'm always happy to review patches if someone else beats me to =
it)

Not precisely what is described here, but I am working on a somewhat generi=
c mechanism for preserving pages across kexec based on this old RFC patch s=
et: https://lkml.org/lkml/2013/7/1/211.=A0 I expect to post patches soon.

Anthony

>
>
> 2) Reuse the SWIOTLB from the previous boot on kexec/kdump
>
> I see little direct relation to SEV here. The only reason SEV makes it mo=
re relevant, is that you need to have an SWIOTLB region available with SEV =
while without you could live with a disabled IOMMU.
>
> However, I can definitely understand how you would want to have a way to =
tell the new kexec'ed kernel where the old SWIOTLB was, so it can reuse its=
 memory for its own SWIOTLB. That way, you don't have to reserve another 64=
MB of RAM for kdump.
>
> What I'm curious on is whether we need to be as elaborate. Can't we just =
pass the old SWIOTLB as free memory to the new kexec'ed kernel and everythi=
ng else will fall into place? All that would take is a bit of shuffling on =
the e820 table pass-through to the kexec'ed kernel, no?
>
>
> Thanks,
>
> Alex
>
>
>
>
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
>
>
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

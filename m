Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2A2C11D2B
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 09:26:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42E6520714
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 09:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtaeuJs1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E6520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1F51F8545D;
	Mon, 24 Feb 2020 09:26:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Bu0hVgAbmF3; Mon, 24 Feb 2020 09:26:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 95C1085740;
	Mon, 24 Feb 2020 09:26:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 835A0C07FF;
	Mon, 24 Feb 2020 09:26:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C37CDC0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 09:26:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BF93486373
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 09:26:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lr-g4UG6Canl for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 09:26:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9143286064
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 09:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582536402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A7OI57zr2blLgJ/hwa1LGfLsiQ0/JgcnoRnFk2JvkkQ=;
 b=QtaeuJs1IVONC4AySs0fKwhwlSaTKm2as0Mfs0RYbRUrh9Uhu5p6ciNmiEEY/3pxY5t9VR
 5SGPNAACPWdfk2dYaTjYRQ+gA4yrepGB/XWscVy9s7M0jRJu2LoCtKMBwnmKAWoNarnlme
 AM+NRSI4j1IftBrCRdgINqlXODM/twA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-u3eLj2MsMI6Rh52UwPOX6g-1; Mon, 24 Feb 2020 04:26:35 -0500
X-MC-Unique: u3eLj2MsMI6Rh52UwPOX6g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6EC5DB20;
 Mon, 24 Feb 2020 09:26:31 +0000 (UTC)
Received: from [10.72.13.147] (ovpn-13-147.pek2.redhat.com [10.72.13.147])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87B9560BF7;
 Mon, 24 Feb 2020 09:26:22 +0000 (UTC)
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <426e6972-0565-c931-e171-da0f58fbf856@redhat.com>
 <20200221155602.4de41fa7.pasic@linux.ibm.com>
 <0181712c-e533-fcfd-2638-8a0649d713dd@redhat.com>
 <20200224010607-mutt-send-email-mst@kernel.org>
 <b3c52c67-c740-a50e-2595-fe04d179c881@redhat.com>
 <20200224024641-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <08d6bdfb-9b49-c278-3c0b-2e02376cf0cf@redhat.com>
Date: Mon, 24 Feb 2020 17:26:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200224024641-mutt-send-email-mst@kernel.org>
Content-Type: multipart/mixed; boundary="------------BDFD2BED5C3364D3CE35012F"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
 "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, David Gibson <david@gibson.dropbear.id.au>,
 Michael Mueller <mimu@linux.ibm.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format.
--------------BDFD2BED5C3364D3CE35012F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 2020/2/24 =E4=B8=8B=E5=8D=883:48, Michael S. Tsirkin wrote:
> On Mon, Feb 24, 2020 at 02:45:03PM +0800, Jason Wang wrote:
>> On 2020/2/24 =E4=B8=8B=E5=8D=882:06, Michael S. Tsirkin wrote:
>>> On Mon, Feb 24, 2020 at 12:01:57PM +0800, Jason Wang wrote:
>>>> On 2020/2/21 =E4=B8=8B=E5=8D=8810:56, Halil Pasic wrote:
>>>>> On Fri, 21 Feb 2020 14:22:26 +0800
>>>>> Jason Wang <jasowang@redhat.com> wrote:
>>>>>
>>>>>> On 2020/2/21 =E4=B8=8A=E5=8D=8812:06, Halil Pasic wrote:
>>>>>>> Currently if one intends to run a memory protection enabled VM wi=
th
>>>>>>> virtio devices and linux as the guest OS, one needs to specify th=
e
>>>>>>> VIRTIO_F_IOMMU_PLATFORM flag for each virtio device to make the g=
uest
>>>>>>> linux use the DMA API, which in turn handles the memory
>>>>>>> encryption/protection stuff if the guest decides to turn itself i=
nto
>>>>>>> a protected one. This however makes no sense due to multiple reas=
ons:
>>>>>>> * The device is not changed by the fact that the guest RAM is
>>>>>>> protected. The so called IOMMU bypass quirk is not affected.
>>>>>>> * This usage is not congruent with  standardised semantics of
>>>>>>> VIRTIO_F_IOMMU_PLATFORM. Guest memory protected is an orthogonal =
reason
>>>>>>> for using DMA API in virtio (orthogonal with respect to what is
>>>>>>> expressed by VIRTIO_F_IOMMU_PLATFORM).
>>>>>>>
>>>>>>> This series aims to decouple 'have to use DMA API because my (gue=
st) RAM
>>>>>>> is protected' and 'have to use DMA API because the device told me
>>>>>>> VIRTIO_F_IOMMU_PLATFORM'.
>>>>>>>
>>>>>>> Please find more detailed explanations about the conceptual aspec=
ts in
>>>>>>> the individual patches. There is however also a very practical pr=
oblem
>>>>>>> that is addressed by this series.
>>>>>>>
>>>>>>> For vhost-net the feature VIRTIO_F_IOMMU_PLATFORM has the followi=
ng side
>>>>>>> effect The vhost code assumes it the addresses on the virtio desc=
riptor
>>>>>>> ring are not guest physical addresses but iova's, and insists on =
doing a
>>>>>>> translation of these regardless of what transport is used (e.g. w=
hether
>>>>>>> we emulate a PCI or a CCW device). (For details see commit 6b1e6c=
c7855b
>>>>>>> "vhost: new device IOTLB API".) On s390 this results in severe
>>>>>>> performance degradation (c.a. factor 10).
>>>>>> Do you see a consistent degradation on the performance, or it only
>>>>>> happen when for during the beginning of the test?
>>>>>>
>>>>> AFAIK the degradation is consistent.
>>>>>
>>>>>>> BTW with ccw I/O there is
>>>>>>> (architecturally) no IOMMU, so the whole address translation make=
s no
>>>>>>> sense in the context of virtio-ccw.
>>>>>> I suspect we can do optimization in qemu side.
>>>>>>
>>>>>> E.g send memtable entry via IOTLB API when vIOMMU is not enabled.
>>>>>>
>>>>>> If this makes sense, I can draft patch to see if there's any diffe=
rence.
>>>>> Frankly I would prefer to avoid IOVAs on the descriptor ring (and t=
he
>>>>> then necessary translation) for virtio-ccw altogether. But Michael
>>>>> voiced his opinion that we should mandate F_IOMMU_PLATFORM for devi=
ces
>>>>> that could be used with guests running in protected mode. I don't s=
hare
>>>>> his opinion, but that's an ongoing discussion.
>>>>>
>>>>> Should we end up having to do translation from IOVA in vhost, we ar=
e
>>>>> very interested in that translation being fast and efficient.
>>>>>
>>>>> In that sense we would be very happy to test any optimization that =
aim
>>>>> into that direction.
>>>>>
>>>>> Thank you very much for your input!
>>>> Using IOTLB API on platform without IOMMU support is not intended. P=
lease
>>>> try the attached patch to see if it helps.
>>>>
>>>> Thanks
>>>>
>>>>
>>>>> Regards,
>>>>> Halil
>>>>>
>>>>>> Thanks
>>>>>>
>>>>>>
>>>>>>> Halil Pasic (2):
>>>>>>>       mm: move force_dma_unencrypted() to mem_encrypt.h
>>>>>>>       virtio: let virtio use DMA API when guest RAM is protected
>>>>>>>
>>>>>>>      drivers/virtio/virtio_ring.c |  3 +++
>>>>>>>      include/linux/dma-direct.h   |  9 ---------
>>>>>>>      include/linux/mem_encrypt.h  | 10 ++++++++++
>>>>>>>      3 files changed, 13 insertions(+), 9 deletions(-)
>>>>>>>
>>>>>>>
>>>>>>> base-commit: ca7e1fd1026c5af6a533b4b5447e1d2f153e28f2
>>>> >From 66fa730460875ac99e81d7db2334cd16bb1d2b27 Mon Sep 17 00:00:00 2=
001
>>>> From: Jason Wang <jasowang@redhat.com>
>>>> Date: Mon, 24 Feb 2020 12:00:10 +0800
>>>> Subject: [PATCH] virtio: turn on IOMMU_PLATFORM properly
>>>>
>>>> When transport does not support IOMMU, we should clear IOMMU_PLATFOR=
M
>>>> even if the device and vhost claims to support that. This help to
>>>> avoid the performance overhead caused by unnecessary IOTLB miss/upda=
te
>>>> transactions on such platform.
>>>>
>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>> ---
>>>>    hw/virtio/virtio-bus.c | 6 +++---
>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
>>>> index d6332d45c3..2741b9fdd2 100644
>>>> --- a/hw/virtio/virtio-bus.c
>>>> +++ b/hw/virtio/virtio-bus.c
>>>> @@ -47,7 +47,6 @@ void virtio_bus_device_plugged(VirtIODevice *vdev,=
 Error **errp)
>>>>        VirtioBusState *bus =3D VIRTIO_BUS(qbus);
>>>>        VirtioBusClass *klass =3D VIRTIO_BUS_GET_CLASS(bus);
>>>>        VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(vdev);
>>>> -    bool has_iommu =3D virtio_host_has_feature(vdev, VIRTIO_F_IOMMU=
_PLATFORM);
>>>>        Error *local_err =3D NULL;
>>>>        DPRINTF("%s: plug device.\n", qbus->name);
>>>> @@ -77,10 +76,11 @@ void virtio_bus_device_plugged(VirtIODevice *vde=
v, Error **errp)
>>>>            return;
>>>>        }
>>>> -    if (klass->get_dma_as !=3D NULL && has_iommu) {
>>>> -        virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLA=
TFORM);
>>>> +    if (false && klass->get_dma_as !=3D NULL &&
>>>> +        virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
>>>>            vdev->dma_as =3D klass->get_dma_as(qbus->parent);
>>>>        } else {
>>>> +        virtio_clear_feature(&vdev->host_features, VIRTIO_F_IOMMU_P=
LATFORM);
>>>>            vdev->dma_as =3D &address_space_memory;
>>>>        }
>>>>    }
>>> This seems to clear it unconditionally. I guess it's just a debugging
>>> patch, the real one will come later?
>>
>> My bad, here's the correct one.
>>
>> Thanks
>>
>>
>>>> --=20
>>>> 2.19.1
>>>>
>> >From b8a8b582f46bb86c7a745b272db7b744779e5cc7 Mon Sep 17 00:00:00 200=
1
>> From: Jason Wang <jasowang@redhat.com>
>> Date: Mon, 24 Feb 2020 12:00:10 +0800
>> Subject: [PATCH] virtio: turn on IOMMU_PLATFORM properly
>>
>> When transport does not support IOMMU, we should clear IOMMU_PLATFORM
>> even if the device and vhost claims to support that. This help to
>> avoid the performance overhead caused by unnecessary IOTLB miss/update
>> transactions on such platform.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   hw/virtio/virtio-bus.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
>> index d6332d45c3..4be64e193e 100644
>> --- a/hw/virtio/virtio-bus.c
>> +++ b/hw/virtio/virtio-bus.c
>> @@ -47,7 +47,6 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, E=
rror **errp)
>>       VirtioBusState *bus =3D VIRTIO_BUS(qbus);
>>       VirtioBusClass *klass =3D VIRTIO_BUS_GET_CLASS(bus);
>>       VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(vdev);
>> -    bool has_iommu =3D virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_P=
LATFORM);
>>       Error *local_err =3D NULL;
>>  =20
>>       DPRINTF("%s: plug device.\n", qbus->name);
>> @@ -77,10 +76,11 @@ void virtio_bus_device_plugged(VirtIODevice *vdev,=
 Error **errp)
>>           return;
>>       }
>>  =20
>> -    if (klass->get_dma_as !=3D NULL && has_iommu) {
>> -        virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATF=
ORM);
> So it looks like this line is unnecessary, but it's an unrelated
> cleanup, right?


Yes.


>
>> +    if (klass->get_dma_as !=3D NULL &&
>> +        virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
>>           vdev->dma_as =3D klass->get_dma_as(qbus->parent);
>>       } else {
>> +        virtio_clear_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLA=
TFORM);
>
> Of course any change like that will have to affect migration compat, et=
c.
> Can't we clear the bit when we are sending the features to vhost
> instead?


That's better.

How about attached?

Thanks


>
>
>>           vdev->dma_as =3D &address_space_memory;
>>       }
>>   }
>> --=20
>> 2.19.1
>>

--------------BDFD2BED5C3364D3CE35012F
Content-Type: text/x-patch;
 name="0001-vhost-do-not-set-VIRTIO_F_IOMMU_PLATFORM-when-IOMMU-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-vhost-do-not-set-VIRTIO_F_IOMMU_PLATFORM-when-IOMMU-.pa";
 filename*1="tch"

From 3177c5194c729f3056b84c67664c59b9b949bb76 Mon Sep 17 00:00:00 2001
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2020 17:24:14 +0800
Subject: [PATCH] vhost: do not set VIRTIO_F_IOMMU_PLATFORM when IOMMU is not
 used

We enable device IOTLB unconditionally when VIRTIO_F_IOMMU_PLATFORM is
negotiated. This lead unnecessary IOTLB miss/update transactions when
IOMMU is used. This patch fixes this.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c | 3 +++
 hw/virtio/vhost.c   | 4 +---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 3627bb1717..0d50e8bd34 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -879,6 +879,9 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
         virtio_net_apply_guest_offloads(n);
     }
 
+    if (vdev->dma_as == &address_space_memory)
+        features &= ~(1ULL << VIRTIO_F_IOMMU_PLATFORM);
+
     for (i = 0;  i < n->max_queues; i++) {
         NetClientState *nc = qemu_get_subqueue(n->nic, i);
 
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 9edfadc81d..711b1136f6 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -288,9 +288,7 @@ static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64_t size)
 
 static int vhost_dev_has_iommu(struct vhost_dev *dev)
 {
-    VirtIODevice *vdev = dev->vdev;
-
-    return virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
+    return virtio_has_feature(dev->acked_features, VIRTIO_F_IOMMU_PLATFORM);
 }
 
 static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
-- 
2.19.1


--------------BDFD2BED5C3364D3CE35012F
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--------------BDFD2BED5C3364D3CE35012F--


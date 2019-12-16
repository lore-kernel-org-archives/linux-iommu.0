Return-Path: <SRS0=eHMU=2G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E85CC2D0C3
	for <iommu@archiver.kernel.org>; Mon, 16 Dec 2019 14:36:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD01206D7
	for <iommu@archiver.kernel.org>; Mon, 16 Dec 2019 14:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RA2ocLWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD01206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C2CD5872E9;
	Mon, 16 Dec 2019 14:36:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7ykw2-EJrUjZ; Mon, 16 Dec 2019 14:36:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 27AD286DFC;
	Mon, 16 Dec 2019 14:36:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EEFDC18DD;
	Mon, 16 Dec 2019 14:36:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 188E9C077D
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 14:36:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 076DF87048
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 14:36:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qp1Xj9uJ-hHZ for <iommu@lists.linux-foundation.org>;
 Mon, 16 Dec 2019 14:36:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 352AF86DFC
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 14:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576506961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zQ14lO5GOkJM4i4EgKkkmU/5WKLUz08i5Wp26RDpbTE=;
 b=RA2ocLWaeac/c/CwZUfZLRv1SiuklIQz2+aVM7HuxzyfBbuYewmy+70tU7C0FQrQh2doov
 bZerWk0ubja1/s+0G/nXPDwadBna31CFRoDTIUDGXVyQN3bjOewCJRNqUEgNl/gtGTDJOz
 iVEnh1BNY7MvrXIMXrCEaXeeKIr1gaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-LXB21lBOPK2lm7ONM2TbaA-1; Mon, 16 Dec 2019 09:35:59 -0500
X-MC-Unique: LXB21lBOPK2lm7ONM2TbaA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 002521005502;
 Mon, 16 Dec 2019 14:35:58 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96C215C28C;
 Mon, 16 Dec 2019 14:35:55 +0000 (UTC)
Subject: Re: [PATCH v3] iommu: fix KASAN use-after-free in
 iommu_insert_resv_region
To: Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20191126102743.3269-1-eric.auger@redhat.com>
 <0DE725CD-01CD-4E01-B817-9CC7F4768FBC@lca.pw>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <80da76c4-395a-18cc-1ffa-c3a0471921b0@redhat.com>
Date: Mon, 16 Dec 2019 15:35:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <0DE725CD-01CD-4E01-B817-9CC7F4768FBC@lca.pw>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: linux-kernel@vger.kernel.org, hch@lst.de, iommu@lists.linux-foundation.org,
 eric.auger.pro@gmail.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,
On 12/16/19 3:24 PM, Qian Cai wrote:
> 
> 
>> On Nov 26, 2019, at 5:27 AM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> In case the new region gets merged into another one, the nr
>> list node is freed. Checking its type while completing the
>> merge algorithm leads to a use-after-free. Use new->type
>> instead.
>>
>> Fixes: 4dbd258ff63e ("iommu: Revisit iommu_insert_resv_region()
>> implementation")
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reported-by: Qian Cai <cai@lca.pw>
>> Cc: Stable <stable@vger.kernel.org> #v5.3+
> 
> 
> Looks like Joerg is away for a few weeks. Could Andrew or Linus pick up this 
> use-after-free?
Thanks for the heads up. Indeed I was wondering why it hasn't been taken
yet.

Note the right version to pick up is the v4, reviewed by Jerry:
https://www.mail-archive.com/iommu@lists.linux-foundation.org/msg36226.html

Thanks

Eric
> 
>>
>> ---
>>
>> v2 -> v3:
>> - directly use new->type
>>
>> v1 -> v2:
>> - remove spurious new line
>> ---
>> drivers/iommu/iommu.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index d658c7c6a2ab..285ad4a4c7f2 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -313,7 +313,7 @@ int iommu_insert_resv_region(struct iommu_resv_region *new,
>> 		phys_addr_t top_end, iter_end = iter->start + iter->length - 1;
>>
>> 		/* no merge needed on elements of different types than @nr */
>> -		if (iter->type != nr->type) {
>> +		if (iter->type != new->type) {
>> 			list_move_tail(&iter->list, &stack);
>> 			continue;
>> 		}
>> -- 
>> 2.20.1
>>
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu

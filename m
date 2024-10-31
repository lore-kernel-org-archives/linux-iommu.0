Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7151B86CF
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391497; cv=none; b=iTix1+bbnIm6ZRxno1l07w6/FBQsBrLvw7JYy46xbYBJHBI8vmLYBVo/Fp6WYiYZbg5sCAwNbAuArNhAgqAkCuqSlBbffEspQxUwzyFwyCmtDQye2DrCUge6g5iB3rlP7SKST4SK+fZI5hoRwF9ceF/4+Ek/BElFY28n9cZL8BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391497; c=relaxed/simple;
	bh=ojkW9Hu+VTnE/iHOguyIaaCPlJONSavA08EZ6kJX/jE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q2QEWziEH2r/wMHZ9Fc91QiFqf3osqYDzJ6sV8/cMlYEO7lYnvIzTnp3xnOm9jrrLQnxBB2sn8A7FmOQqkllTEGnJlXIybX9uXKSVHqVJDMLSn4NfYfNE4qXeFgYPQym9HDRhoUYR/H0ZcuiDxpmkJ7TWwSQmdcc7xIwyo2tO8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DgtgJaBV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DgtgJaBV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730391492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyMxjyMJzDjgdzMLpj9RIlepCqJ9T1p2ImGI0IFMw38=;
	b=DgtgJaBVdoskpUry3Jo3BP7P5GX3GxQNRm0JGCY6uYtYh01Ik9nCBxZtY4An4lM1zJneNT
	dJt1DgjT03gfiSLNSab9sKrHooz1QkWL/OWiBukco0TKEl9+lnbSA1/S1/oy/cjxctG1xO
	Di5wtLaHK9xAN0gD8ygrqkeQVaK4OmI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-pyOeBEXLPRivxKnBx5oCOw-1; Thu, 31 Oct 2024 12:18:11 -0400
X-MC-Unique: pyOeBEXLPRivxKnBx5oCOw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a2ccb77ceso84879266b.2
        for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 09:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730391490; x=1730996290;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxx09rhPXBW0+fbvKhcDxytRWwt5G4IT/stJwiAJCe0=;
        b=trliys2wjdK38Tb6MbOQunpSOIwe3mYAo1jGEdoDKZ2UCHuZQfwTPOALW/DFALGtt5
         pQLw3ED34xW6HUvgL5e34awYGwHDBXFFtHEATMM41hJh9Ck6fIzs0cN4o5hBTSuENNMS
         dY4ig/ndeG2wAUGw4on+6ARzVxnd6lVZspEXv4briErB7weqQyF9qxCAZGudW48EX/WA
         7eNN6Zer05bFNzQJPcz4zwV+i/GlbqEAMZnHoqpmlfzAERA9K680ddmpiUEo8qXLITrf
         slbcVzcYgOF4f5VlSS1LCTCa0p7xfEgTdRtQ3K63LbRJeKzCxzIHKtLJ7HXdMLckGOWV
         u8hw==
X-Forwarded-Encrypted: i=1; AJvYcCU+LaNHsoIO0y1ibteij2PRSTMmCRc15hVSE3kxx4rDNtvMYEli4OB5FnZi0fCRmMl3e8yJqA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywmbf7dBlq0D0X3OHcalfGsdfkkAjnLcevDt8Na7Qbn0Fs0L6DC
	oOL9Zp4wv3qadwH/ACDgDJz90uMebEk4GTTCZ+nnSui+GEmluV1oAStx+9V2H/B5b9c7o4y8/As
	Ry9qpEJ6NsBYYCjNSgU5O1fMfbP7c30prDYJlGK0PsCOXRRdOy/Zx
X-Received: by 2002:a17:907:96ac:b0:a9a:1796:30d0 with SMTP id a640c23a62f3a-a9de63327c3mr2013677866b.62.1730391489856;
        Thu, 31 Oct 2024 09:18:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcPr4JkEYqmPz2R4rXU5fH3oMbGqzpFoCe3YaKkRKxGz/Uy/aeNVT/TYWyZnSar5vduQlf6g==
X-Received: by 2002:a17:907:96ac:b0:a9a:1796:30d0 with SMTP id a640c23a62f3a-a9de63327c3mr2013674966b.62.1730391489327;
        Thu, 31 Oct 2024 09:18:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56645ecesm84789766b.178.2024.10.31.09.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 09:18:08 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id CEC11164B7AF; Thu, 31 Oct 2024 17:18:07 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: zhangkun09@huawei.com, fanghaiqing@huawei.com, liuyonglong@huawei.com,
 Robin Murphy <robin.murphy@arm.com>, Alexander Duyck
 <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kernel-team
 <kernel-team@cloudflare.com>
Subject: Re: [PATCH net-next v3 3/3] page_pool: fix IOMMU crash when driver
 has already unbound
In-Reply-To: <023fdee7-dbd4-4e78-b911-a7136ff81343@huawei.com>
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
 <20241022032214.3915232-4-linyunsheng@huawei.com>
 <dbd7dca7-d144-4a0f-9261-e8373be6f8a1@kernel.org>
 <113c9835-f170-46cf-92ba-df4ca5dfab3d@huawei.com> <878qudftsn.fsf@toke.dk>
 <d8e0895b-dd37-44bf-ba19-75c93605fc5e@huawei.com> <87r084e8lc.fsf@toke.dk>
 <cf1911c5-622f-484c-9ee5-11e1ac83da24@huawei.com> <878qu7c8om.fsf@toke.dk>
 <1eac33ae-e8e1-4437-9403-57291ba4ced6@huawei.com> <87o731by64.fsf@toke.dk>
 <023fdee7-dbd4-4e78-b911-a7136ff81343@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 31 Oct 2024 17:18:07 +0100
Message-ID: <874j4sb60w.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunsheng Lin <linyunsheng@huawei.com> writes:

> On 2024/10/30 19:57, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Yunsheng Lin <linyunsheng@huawei.com> writes:
>>=20
>>>> But, well, I'm not sure it is? You seem to be taking it as axiomatic
>>>> that the wait in itself is bad. Why? It's just a bit memory being held
>>>> on to while it is still in use, and so what?
>>>
>>> Actually, I thought about adding some sort of timeout or kicking based =
on
>>> jakub's waiting patch too.
>>>
>>> But after looking at more caching in the networking, waiting and kickin=
g/flushing
>>> seems harder than recording the inflight pages, mainly because kicking/=
flushing
>>> need very subsystem using page_pool owned page to provide a kicking/flu=
shing
>>> mechanism for it to work, not to mention how much time does it take to =
do all
>>> the kicking/flushing.
>>=20
>> Eliding the details above, but yeah, you're right, there are probably
>> some pernicious details to get right if we want to flush all caches. S
>> I wouldn't do that to start with. Instead, just add the waiting to start
>> with, then wait and see if this actually turns out to be a problem in
>> practice. And if it is, identify the source of that problem, deal with
>> it, rinse and repeat :)
>
> I am not sure if I have mentioned to you that jakub had a RFC for the wai=
ting,
> see [1]. And Yonglong Cc'ed had tested it, the waiting caused the driver =
unload
> stalling forever and some task hung, see [2].
>
> The root cause for the above case is skb_defer_free_flush() not being cal=
led
> as mentioned before.

Well, let's fix that, then! We already logic to flush backlogs when a
netdevice is going away, so AFAICT all that's needed is to add the
skb_defer_free_flush() to that logic. Totally untested patch below, that
we should maybe consider applying in any case.

> I am not sure if I understand the reasoning behind the above suggestion t=
o 'wait
> and see if this actually turns out to be a problem' when we already know =
that there
> are some cases which need cache kicking/flushing for the waiting to work =
and those
> kicking/flushing may not be easy and may take indefinite time too, not to=
 mention
> there might be other cases that need kicking/flushing that we don't know =
yet.
>
> Is there any reason not to consider recording the inflight pages so that =
unmapping
> can be done for inflight pages before driver unbound supposing dynamic nu=
mber of
> inflight pages can be supported?
>
> IOW, Is there any reason you and jesper taking it as axiomatic that recor=
ding the
> inflight pages is bad supposing the inflight pages can be unlimited and r=
ecording
> can be done with least performance overhead?

Well, page pool is a memory allocator, and it already has a mechanism to
handle returning of memory to it. You're proposing to add a second,
orthogonal, mechanism to do this, one that adds both overhead and
complexity, yet doesn't handle all cases (cf your comment about devmem).

And even if it did handle all cases, force-releasing pages in this way
really feels like it's just papering over the issue. If there are pages
being leaked (or that are outstanding forever, which basically amounts
to the same thing), that is something we should be fixing the root cause
of, not just working around it like this series does.

-Toke


Patch to flush the deferred free list when taking down a netdevice;
compile-tested only:



diff --git a/net/core/dev.c b/net/core/dev.c
index ea5fbcd133ae..6e64e24ad6fa 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5955,6 +5955,27 @@ EXPORT_SYMBOL(netif_receive_skb_list);
=20
 static DEFINE_PER_CPU(struct work_struct, flush_works);
=20
+static void skb_defer_free_flush(struct softnet_data *sd)
+{
+=09struct sk_buff *skb, *next;
+
+=09/* Paired with WRITE_ONCE() in skb_attempt_defer_free() */
+=09if (!READ_ONCE(sd->defer_list))
+=09=09return;
+
+=09spin_lock(&sd->defer_lock);
+=09skb =3D sd->defer_list;
+=09sd->defer_list =3D NULL;
+=09sd->defer_count =3D 0;
+=09spin_unlock(&sd->defer_lock);
+
+=09while (skb !=3D NULL) {
+=09=09next =3D skb->next;
+=09=09napi_consume_skb(skb, 1);
+=09=09skb =3D next;
+=09}
+}
+
 /* Network device is going away, flush any packets still pending */
 static void flush_backlog(struct work_struct *work)
 {
@@ -5964,6 +5985,8 @@ static void flush_backlog(struct work_struct *work)
 =09local_bh_disable();
 =09sd =3D this_cpu_ptr(&softnet_data);
=20
+=09skb_defer_free_flush(sd);
+
 =09backlog_lock_irq_disable(sd);
 =09skb_queue_walk_safe(&sd->input_pkt_queue, skb, tmp) {
 =09=09if (skb->dev->reg_state =3D=3D NETREG_UNREGISTERING) {
@@ -6001,6 +6024,9 @@ static bool flush_required(int cpu)
 =09=09   !skb_queue_empty_lockless(&sd->process_queue);
 =09backlog_unlock_irq_enable(sd);
=20
+=09if (!do_flush && READ_ONCE(sd->defer_list))
+=09=09do_flush =3D true;
+
 =09return do_flush;
 #endif
 =09/* without RPS we can't safely check input_pkt_queue: during a
@@ -6298,27 +6324,6 @@ struct napi_struct *napi_by_id(unsigned int napi_id)
 =09return NULL;
 }
=20
-static void skb_defer_free_flush(struct softnet_data *sd)
-{
-=09struct sk_buff *skb, *next;
-
-=09/* Paired with WRITE_ONCE() in skb_attempt_defer_free() */
-=09if (!READ_ONCE(sd->defer_list))
-=09=09return;
-
-=09spin_lock(&sd->defer_lock);
-=09skb =3D sd->defer_list;
-=09sd->defer_list =3D NULL;
-=09sd->defer_count =3D 0;
-=09spin_unlock(&sd->defer_lock);
-
-=09while (skb !=3D NULL) {
-=09=09next =3D skb->next;
-=09=09napi_consume_skb(skb, 1);
-=09=09skb =3D next;
-=09}
-}
-
 #if defined(CONFIG_NET_RX_BUSY_POLL)
=20
 static void __busy_poll_stop(struct napi_struct *napi, bool skip_schedule)


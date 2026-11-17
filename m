Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794880468;
	b=MILffZ2VV6tc7kivgf7b0sL1I0bq5dGOsd7MASfLr7uMLqFrNJmuMN2C070xWbbq4D0z
	 JR8sqY6YjbZpTHw0DZKhOC/rcWhNZhfYC3/CrwJqaVBdG2LOyrwQZtwlvPC5n1ri4/V9/
	 JFPER5MJ5+wi2SVR02ZmDps0hPfZjKEsVayo2cD9GhO/lVx/sjI2SWis/Z4xZgYbjLP6i
	 PEmeDlee4ZVmECf6iIlfNnqmgsmH2ypOvIowbwM9uHfHIpe0P1/c8UpRPrvJ3w8yP+Vky
	 hLkAchwuw5icYA+cgLlovSw90V6+xM9xsXbLw5SXsr8TaRvwq8nx8Zu3cSA57iHjDJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794880468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=w8LqwAm420t4vMGPQi+EWJzp7fMp2OcaMgt7Y6fyyHA=;
	b=zIzTHjjx0NWKjTo3ThCHLUdYq2iw2+yGQ1h6AtNOe6TGw8kOU/wvZXJZiz/y1+jmDiY/
	 y8d9H2x+ss/Dv08xue/hb/kJzHIUgP7jGlWCWXRiGZ2EJKD9HX9szIQjyaiZsrPN4NtNr
	 Ocq01BrJr5wOzfJtHRdNHQeiHlomYMfMuNjYr0amZv/p4IhI+JcKvo/6pKXP/Ag3vL1Le
	 UFxtx0S3aTKeVJEk1M/Bq9IQsT6xROq17qWnuDywuepbNEU87S0iw7xc8Ods3u5OfgBsO
	 +Z4f6pUT70Y16C1FMSXQ49ijxXH6gNnZMNorFAeouZCNV51HTgAgiSl21G4B6pl1q/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EQQSJXQL;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9553D606A31C
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 01:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9553D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EQQSJXQL
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-37123334649so430450eec.1
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 17:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794880467; x=1795485267; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w8LqwAm420t4vMGPQi+EWJzp7fMp2OcaMgt7Y6fyyHA=;
        b=EQQSJXQL4L47ECBJsKntesQDxSqP8SfYvTAXIIZm24kLMF8Yve56KHdBO2vFRENtuo
         4EOob/T4uakv6fv4GkT75cqy11wboFkelrDvae/1pn+gparhhJZNOrPeLDN1yJ+G0d4X
         jeYs3kWsTAbWPeOmYxqL9Yma4w5b2aP2BC20PXgJ5dnrWiuzkKYoBoQrY0A2NZYLiTTx
         9Z7NNVH9/ThkzIZ7I7pInwYIH7hiimkiLi6VLyK1il/AusoJrtiJbq678NUZIRhic0ic
         5tsV3NGPQ2ZpVWRKqJ6LDOKGp6Zj48eMEzqz4iFJx5IqgoLFhvbWexlQi6KggSKytohY
         olww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794880467; x=1795485267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w8LqwAm420t4vMGPQi+EWJzp7fMp2OcaMgt7Y6fyyHA=;
        b=er2sV/Q2leaVIc8N7AhizK6828eBWlSTtrZksUpVGrNCHq63aZV9x5qwqeAJL7UHCV
         bpGyKkUR0Xccx1XCVYRiLX7IF+sCk+gpBn5lkkHCaCQM19iTWa9BvJBOCOk4F01B28Sc
         Mo7oYGWS+nvwB048uTIU1y/Q/CCMItbJeUsbAGiH4yto3S/PmMt1pYFI0eaK4yE7NyH3
         TLPQrwjGiorSjRNePWQEdMqYu7MRxJjQcE80dUql4g/3/Ma3ohYk/E20hWapm2YtX/yX
         naD+dEH8GLfVcvfE+Ck+jn2tSRAFN1n3qrsgatROZQ0/+auFicNh/yQ8Bh35JuutvBWn
         HK8A==
X-Forwarded-Encrypted: i=1; AL+hErHzUeXv7NAIJTseGEljPe3ImzovY1vjoeeS1CcTWWJtvQEgYaaghNE3jFOJJziqhTnM3yvX5Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z+cyHJ26l9WmHcmE1uAaF/w/vKusctERiOP10mbpZ/Qel6wXGhl
	zBoE4fFQcAlT5oCQsn9DCUoKsP8TWmG1AXHkctAgLQeShzS4/0RFT/su
X-Gm-Gg: AZFdTZcYULLe/BQlHQDy6X0rZkhf6onmzeatEYJf5A5qmiotmkIOzmsMVUVuLPSDjE/
	EipphE5bEjosdi6JUI2lHuiTNo7Svvvo4qoHHowZq4sBZPQ4nbv37Zfc3XT0RIZSHv/T72dzcQP
	SDWOp/FJO0xoeNITdaBtmdTRvKYTFXNyf3BoqmAwnghwDxqWXJGBNCyUhDgyOSTjfPMwWIniMLy
	VYj9O3W2NeI05hracjz+xgiY7Nylh8uess5TTrA5Ec4VwZ/DrR1ZXcUr6RgGfYPNkZ5yNzjXOt6
	uTw5vuEBCEIyKBxUtdyU3Jkq+nR2Csk6aFnmszkKEJZwOfq393a2HpeqVXiP01wBWO8q+mgyMMD
	Gi/uT/JCCo1IfyRH1c/FPYsZevCjow4McV8EGBer2/6zYoFq/1Sa5D1a5ZQIqdIA3BpmopNzmfk
	ZwUiXv/4DDPRlCkf3q0iwVRrXSNMD3RPdtc6pnswouTBGPVSKB1PdSirC5VG6Ofgo84U7UBrjIl
	8xqqWPrjB02vfDV09BGJ98cc+KKM2pvBNmzF++wY5UDhlud4tWhuyFJvinZO7x5gHm/c8aZyMFC
	jYpB9nr7MVgn0coocklm6bJZJccteBKBkQwo5ZNu51Cvi3RKz+pSvh3jjLc9sjVMFGgO6H7m3MV
	j7G68fu1fhJ8puw7x5gE=
X-Received: by 2002:a05:7300:c00e:20b0:35e:d21c:f33e with SMTP id 5a478bee46e88-379651ecb3emr20449628eec.1.1794880466543;
        Mon, 16 Nov 2026 17:54:26 -0800 (PST)
Received: from localhost.localdomain ([188.253.120.78])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955332a77sm34139971eec.4.2026.11.16.17.54.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 17:54:26 -0800 (PST)
From: Qihang <q.h.hack.winter@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Qihang <q.h.hack.winter@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iommu/io-pgfault: reject partial faults after device removal
Date: Tue, 17 Nov 2026 09:54:07 +0800
Message-ID: <20261117015409.25492-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iopf_queue_remove_device() kfree()s the entries on
fault_param->partial without unlinking them, leaving the list head
pointing into freed memory.  Since a74c077b9021 the fault parameter is
refcounted and can outlive the drain, a report that took its reference
earlier can still list_add() through those pointers.  Unlinking
instead turns that into a leak: the late node lands on a parameter
that is no longer on queue->devices, whose final put does not free
partial faults.

This needs a device removed from its iopf queue while a non-last
(partial) request is in flight, with the caller not blocking new reports
for the duration.

Patch 1 unlinks each partial before freeing it, matching
iopf_queue_discard_partial().

Patch 2 adds fault_param->removing, set and tested under
fault_param->lock: a late partial is either drained, or rejected and
freed by report_partial_fault() (-ENODEV).  It covers partial-list
admission only; callers must still quiesce reports for the remaining
lifetimes.

Both patches are scoped to fault_param->partial, not the group path,
the attach handle, or paths that never call iopf_queue_remove_device().

Verified on v7.4-rc3 with KASAN + DEBUG_LIST and the iommufd mock
driver, its caller-side IOPF serialization deliberately removed and
test-only delays added; this shows the mechanism, not production
reachability.  The runs cover queue-before-removal,
removal-before-insertion, concurrent late reporters and re-enable.
Each round queues one partial before the removal and then races the
late reporters against the drain, so a clean run ends with every node
accounted for: 1800 = 900 + 900 and 3600 = 900 + 2700 (allocated =
drained + rejected), counted at a final removal with no reporter in
flight.  Nothing was left on fault_param->partial and KASAN stayed
quiet.

With patch 1 reverted, the report is:

  BUG: KASAN: slab-use-after-free in __list_add_valid_or_report
  Freed by task 1: kfree <- iopf_queue_remove_device
  56 bytes inside a freed 64-byte region (struct iopf_fault, list.prev)

With patch 1 only, the same reproducer runs 1460 rounds without a KASAN
report and leaks one late node per round, which patch 2 addresses.

Reachability on an unmodified production kernel, and any security
impact, remain unconfirmed: the test shows memory corruption and a
KASAN panic on the modified mock driver, not a user-triggerable bug on
a stock kernel.

An AI coding assistant helped find this defect and build the
reproducer and instrumentation, which are available on request along
with the KASAN logs.

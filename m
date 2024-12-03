Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AA41362
	for <iommu@lists.linux.dev>; Tue,  3 Dec 2024 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733251756; cv=none; b=u0BEJw9ODULyYOpaycfhCJSvlh2pqgIqJ9ksrglYVIyjGZ2BreWOG7N+jEChqJCmz88dWH3Rnygy9LLmPpyP+pfuLdz8NtIrY5JuIw+dmu/YS4ulm2EVIh04my/Gg/KJg2YE2r2FEl/AKOlfnGJh8z3Sazhzi/nwkuVwnIA3IT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733251756; c=relaxed/simple;
	bh=J+Wj9AaHHjblKRfnfhkcuJAPlBKFTf6FMXj57BOemj8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hTqApSKagKWcESb0EeEUZwreTRvKnWsAIyrkHCBtiTzSU8mBeLn/AyHZ4MsDAz52+OBr7EJCaSbxSjLQZeeVEdc168mCqImZu0Vskln9BMqZms5H/a4PwMizyyxDMuKh6lvwc09fqp1kVcSj9+zeKr9jVFEv9ehdyFCS8rV3VwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=grloeMrD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="grloeMrD"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ee5616e986so5744640a91.2
        for <iommu@lists.linux.dev>; Tue, 03 Dec 2024 10:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733251752; x=1733856552; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ge8x+5yoMH2mIMJZ3dWNkMamKfK5ktY50I58jN9lcjw=;
        b=grloeMrDIr28RfQxvzDCAdKBC5qgWRqQGFPQoA7g9+CZ8esY0HeYDPSKHVGQOK7Noa
         OLuQDSicuYP6DsgtMAcMzWIpYKmS6qiKJTCYqKkWcRfMO94dJMP0cOdkW0EBttHsAT+f
         gs0k2oIvk9fpqwRwMQi7zeU4+w2x2DiGsivxcyiHq0UXFjsI6YYL4+iignr60wLvKDa+
         CIYfWPg/ujbhZ2EK//DDrl33V14qOFJfVdTn+8ZbAMsgZOsN8nDjDNbcrpny83WIPrEP
         8cVSbFhdc2/D+nqetzjE6POP8JUnNzqM04YcBCszlMGJAWDMtIiew7wZAg1qX+ZWNwB/
         Totg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733251752; x=1733856552;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ge8x+5yoMH2mIMJZ3dWNkMamKfK5ktY50I58jN9lcjw=;
        b=uedGrCscmjFJvQ/8eseo9WSHbqOfFLN3p3qlgqpym2N30XVAoz/wqBlIlBTdcHNXIU
         xmISwskLkI+Y0yLTvkF9vms/cm8srN13BQlQG7AlQVxPoyywv5AZOiZHd86Z+k9bOq/u
         DqltKGL/1mIrQw1ehpdJXsNLOr5gI0OGX7Hw0arqdZw3cdGDm6CKOziXhbP92R2v4xbo
         iR0nwaY/AmqsK863XL6KsmhPn9ARFIZn7YuWtYefauqwbMigF66lgvVe3b8zx+SR6mia
         wxTqsZSMl1imtZDjobsjhPaJDfoJZWuxpYKZEhs/wuLFj+54tqJXoEWyaF28eY6ptDzX
         1YRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzqDd1WU3WlJGDW7OYRRJ3jEjIhM6VvwnMTZIjWTrEmKnhG+yrB8cqsgWUYws0yMdet8xtaA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxxv3WY7UcIZaU7YvlIGcpOAySAD1HlFfQvHbAywTkcUsIzyu1o
	cgR8J0+dl82fyta5TbBnpqSwtrhghEI4e8C/yB9fk8sGf7hz1R4y8pYiEjz1NC3YVeAaMqpRVw=
	=
X-Google-Smtp-Source: AGHT+IH8DPDCgTssHOj1zTYeXxslC0ljaz+ZHsSSV6EvRp3BxZUNzhWVT5LRLidh5+zSj6tN0+jNsx53vw==
X-Received: from pjbsl6.prod.google.com ([2002:a17:90b:2e06:b0:2e0:9fee:4b86])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ecb:b0:2ee:b8ac:73b0
 with SMTP id 98e67ed59e1d1-2ef011e3749mr4565190a91.2.1733251752543; Tue, 03
 Dec 2024 10:49:12 -0800 (PST)
Date: Tue,  3 Dec 2024 18:49:04 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203184906.2264528-1-praan@google.com>
Subject: [PATCH v6 0/2] iommu/arm-smmu-v3: Parse out event records
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Enhance the arm-smmu-v3 driver to parse out useful information from
event records into a structure for better event handling & logging.

Some sample events, powered by QEMU:

1. Bad StreamID:

[   10.940765] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x02 received:
[   10.941260] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000800000002
[   10.941735] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
[   10.942211] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
[   10.942706] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
[   10.943357] arm-smmu-v3 arm-smmu-v3.0.auto: event: C_BAD_STREAMID client: 0000:00:01.0 sid: 0x8 ssid: 0x0

2. Permission Fault:

[    7.477618] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x13 received:
[    7.478185] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000800000013
[    7.478666] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000020000000000
[    7.479443] arm-smmu-v3 arm-smmu-v3.0.auto:  0x00000000fffff040
[    7.479929] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
[    7.480410] arm-smmu-v3 arm-smmu-v3.0.auto: event: F_PERMISSION client: 0000:00:01.0 sid: 0x8 ssid: 0x0 iova: 0xfffff040 ipa: 0x0
[    7.481258] arm-smmu-v3 arm-smmu-v3.0.auto: unpriv data write s1 "Input address caused fault" stag: 0x0

3. STE Fetch Fault:

[    7.548667] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x03 received:
[    7.549304] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000800000003
[    7.549800] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
[    7.550298] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
[    7.550780] arm-smmu-v3 arm-smmu-v3.0.auto:  0x00000000000001e0
[    7.551568] arm-smmu-v3 arm-smmu-v3.0.auto: event: F_STE_FETCH client: 0000:00:01.0 sid: 0x8 ssid: 0x0 fetch_addr: 0x1e0


5. Unknown / Implementation-defined Fault:

[   13.517857] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x0b received:
[   13.518339] arm-smmu-v3 arm-smmu-v3.0.auto:  0x000000080000000b
[   13.518814] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000028800000000
[   13.519311] arm-smmu-v3 arm-smmu-v3.0.auto:  0x00000000ffffe004
[   13.519789] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
[   13.520294] arm-smmu-v3 arm-smmu-v3.0.auto: event: UNKNOWN client: 0000:00:01.0 sid: 0x8 ssid: 0x0

v6
 * Re-structured the logs in 2 lines with prefixes as suggested.
 * Masked address fields appropriately to avoid issues with RES0
 * Added a member for fetch_address to demarcate it separately.
 * Used `FIELD_GET` where required instead of masking.
 * Renamed `raw_evt` to `evt` and `evt` to `event` as suggested.
 * Renamed `arm_smmu_handle_evt` to `arm_smmu_handle_event`.

v5
 https://lore.kernel.org/all/20241112083018.1662104-1-praan@google.com/
 * Replaced strings with used macros to conserve stack space
 * Fixed IPA log truncation,(e.g. logged 0xfffff instead of 0xfffff040)
 * Bounded evt->id by ARRAY_SIZE to avoid inflating event_str
 * Restored the original raw dump format
 * Decoupled "raw" event from `struct arm_smmu_event`
 * Moved the raw event log before the decoded/pretty log
 * Improved the sid.ssid format to be more readable
 * Zero-initialized the `arm_smmu_event` var in `arm_smmu_handle_evt`
 * Refactored struct arm_smmu_events to use bitfields instead of bools
 * Removed `struct arm_smmu_device` field from `struct arm_smmu_event`
 * Removed `master_name` field to use `dev_name(event->dev)` instead
 * Pahole reports a total of 3-byte holes & struct size = 40 bytes
 * Moved most constant parts of the log to the fmt string
 * Moved the event decoding within `arm_smmu_handle_evt`
 * Renamed `arm_smmu_get_event_from_raw` => `arm_smmu_decode_event`
 * Renamed a few EVT_IDs for consistency as per Daniel's suggestions
 * Renamed "master" to "client" in the logs as suggested in reviews
 * Corrected "F_VMS_FAULT" => "F_VMS_FETCH"
 * Re-ordered event strings in event_str as they appear in the spec
 * Removed less useful comments

v4
 https://lore.kernel.org/all/20241018180022.807928-1-praan@google.com/
 * Re-arranged the series to first introduce struct arm_smmu_event
 * Improved the complex ternary expression that prints TTRnW info
 * Added consistent spacing to the logs & resized log strings
 * Moved ratelimiting within `arm_smmu_dump_event`
 * Refactored master_name printing by getting a ref to the device
 * Refactored `arm_smmu_handle_evt` to avoid redundant master lookup

v3
 https://lore.kernel.org/all/20240928005143.2378938-1-praan@google.com/
 * Fixed a potential race and null pointer deref for arm_smmu_master
 * Improved the logging approach by using multiple strings
 * Added logs for STAG & STALL fields for relevant events
 * Invoked the log function within `arm_smmu_handle_evt` routine
 * Rebased the changes

v2
 https://lore.kernel.org/linux-iommu/20240827193026.3993039-1-praan@google.com/
 * Addressed review comments
 * Introduced `struct arm_smmu_event` to hold relevant event fields
 * Broke out helper functions to populate & dump event info
 * Modified the event handler routines to use `struct arm_smmu_event`

v1
 https://lore.kernel.org/linux-iommu/20240816211722.1404070-1-praan@google.com/

 * Replaced strings with used macros to conserve stack space
 * Fixed IPA log truncation,(e.g. logged 0xfffff instead of 0xfffff040)
 * Bounded evt->id by ARRAY_SIZE to avoid inflating event_str
 * Restored the original raw dump format
 * Decoupled "raw" event from `struct arm_smmu_event`
 * Moved the raw event log before the decoded/pretty log
 * Improved the sid.ssid format to be more readable
 * Zero-initialized the `arm_smmu_event` var in `arm_smmu_handle_evt`
 * Refactored struct arm_smmu_events to use bitfields instead of bools
 * Removed `struct arm_smmu_device` field from `struct arm_smmu_event`
 * Removed `master_name` field to use `dev_name(event->dev)` instead
 * Pahole reports a total of 3-byte holes & struct size = 40 bytes
 * Moved most constant parts of the log to the fmt string
 * Moved the event decoding within `arm_smmu_handle_evt`
 * Renamed `arm_smmu_get_event_from_raw` => `arm_smmu_decode_event`
 * Renamed a few EVT_IDs for consistency as per Daniel's suggestions
 * Renamed "master" to "client" in the logs as suggested in reviews
 * Corrected "F_VMS_FAULT" => "F_VMS_FETCH"
 * Re-ordered event strings in event_str as they appear in the spec
 * Removed less useful comments

v4
 https://lore.kernel.org/all/20241018180022.807928-1-praan@google.com/
 * Re-arranged the series to first introduce struct arm_smmu_event
 * Improved the complex ternary expression that prints TTRnW info
 * Added consistent spacing to the logs & resized log strings
 * Moved ratelimiting within `arm_smmu_dump_event`
 * Refactored master_name printing by getting a ref to the device
 * Refactored `arm_smmu_handle_evt` to avoid redundant master lookup

v3
 https://lore.kernel.org/all/20240928005143.2378938-1-praan@google.com/
 * Fixed a potential race and null pointer deref for arm_smmu_master
 * Improved the logging approach by using multiple strings
 * Added logs for STAG & STALL fields for relevant events
 * Invoked the log function within `arm_smmu_handle_evt` routine
 * Rebased the changes

v2
 https://lore.kernel.org/linux-iommu/20240827193026.3993039-1-praan@google.com/
 * Addressed review comments
 * Introduced `struct arm_smmu_event` to hold relevant event fields
 * Broke out helper functions to populate & dump event info
 * Modified the event handler routines to use `struct arm_smmu_event`

v1
 https://lore.kernel.org/linux-iommu/20240816211722.1404070-1-praan@google.com/

Pranjal Shrivastava (2):
  iommu/arm-smmu-v3: Introduce struct arm_smmu_event
  iommu/arm-smmu-v3: Log better event records

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 157 ++++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  30 ++++
 2 files changed, 162 insertions(+), 25 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


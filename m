Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37FD20B7F6
	for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 08:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400227; cv=none; b=lOtufS6sHX5Z8PUipUAoEPj9p0EwlJU4aHx45B9RC/J4P4Wv5d+IDZCGy9+s1lM9ENyc4VtHipIJJtkHwIZ5IjmQdiUk+Lspbtx8F4Az87hmhTJFnvc+/cBkFxshGeFY4PXX9vTMtHmMZZju1mJE1BFt1Yf7j7kDI3wsEk9NRZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400227; c=relaxed/simple;
	bh=zziIPcODdYSe8pC4XgZk91xrKEkcIIhqE6vtqCu1xEE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=O2s/JpolvDgiyLfljjFhOogAMeWlknZCfZmDPbxnpnFpgYOjLGU4JSTOD+wHXhNdgmsf4gJ+89C3TkIah4k7bAzfeVNarvNHNYVtNYlewPN32C+gbi0CMN+cwmwHCB++WrTr21uPke1NsfBINd+itXWX68h9alFXlmGufLHwIvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fGES4YGW; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fGES4YGW"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28fc8902e6so9705162276.0
        for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 00:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731400225; x=1732005025; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kAgDKR09RvFjW9rLJwyEiLdA19SiaqSHsB15d/XyH7o=;
        b=fGES4YGWQ6I7sGNXo8vBM+VotMf5+YpYcaeoEbJQ3eVM1VyJvNSpEKPsMhhsGU5WZy
         Yq5uADMVRIu9NiS7lMLdboQRXq8RdsQFyf2tyyQKo9vFEYSQFSFrgzCZlnDYvmtNTzac
         QFQkKr6NXClAbpbbe6CXte9n/HfQUINs4saqeZLjdDzEP0joA4D3DoDKETMO3WKmYxj2
         IbIK5V8JtCwd7gJqfZlqZi/VkqBYAkABKUVXvjIaETZ4hnuv5YQaBqXncemGH75y+Bc/
         k0FV89VuaSOHGdjyDIEV8qZVsMrKH1jAgpQgMEoJjF3EAVu97lFWwiL9Wbkp6wARxuRC
         cWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731400225; x=1732005025;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kAgDKR09RvFjW9rLJwyEiLdA19SiaqSHsB15d/XyH7o=;
        b=t0XWb8HISDbPRwz0bbK3UIzVXlFz/QkExuom3dsMNbPcSznjzESnu1fS6YmP69TV0c
         kVmtH1Fkvs5j1kQCiJdCHFb8T1jZxNSh6TmbNjBdPk1Jz3fZ4RE5eJs7I2g+1g0ls5VZ
         CwGjBPLcwiTo5qAS3nDft63lys1rHWGwcPErWbNVMoK9MmECNozgHVVWcWqaal1QXlJE
         8qqCt8mHwQtBZJ9OVKJtERw/hWuQTT3aITmB9+5wLeQts9z5MXT/hBIGnydqG80RrJvl
         g8RpC+hazS4fL9WuftiEgs/pqokYZfJNDm3wZpBpeJyUXl3pMrzEYZuk9cT0m1XE5znB
         D1bw==
X-Forwarded-Encrypted: i=1; AJvYcCXDLYOxuaXmjGIkG+IV1F63sq0BnWW7q9FVPMTtTrdlkmbjfbaC2HO6oYEz1bkPuzx75FyyDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yza/cy9OPLiZlIRggygEqgnyVU88kidgJZTjCjpbR9fAl240Me5
	f/gdeGCHf7+ekB/ke9D1oPGeACRCSW8MnWUgdJPomHIzsrB1S/+DM3/y1aSYvVQb0S7EOJQNJQ=
	=
X-Google-Smtp-Source: AGHT+IGsswWhd1S6SL1vwbSo9QMmVPTFvKzP9McB35pqQQhntxmCn5TGw/926/BjicSN/zGC4iGoPefy4Q==
X-Received: from praan.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3e89])
 (user=praan job=sendgmr) by 2002:a25:b78d:0:b0:e24:9f58:dd17 with SMTP id
 3f1490d57ef6-e337f84160dmr36369276.1.1731400224834; Tue, 12 Nov 2024 00:30:24
 -0800 (PST)
Date: Tue, 12 Nov 2024 08:30:15 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112083018.1662104-1-praan@google.com>
Subject: [PATCH v5 0/3] iommu/arm-smmu-v3: Parse out event records
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

[    7.521940] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x02 received:
[    7.522485] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000800000002
[    7.523335] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
[    7.523814] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
[    7.524281] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
[    7.524759] arm-smmu-v3 arm-smmu-v3.0.auto: Event 0x2 received: C_BAD_STREAMID
[    7.524759]  client: 0000:00:01.0 sid: 0x8 ssid: 0x0

2. STE Fetch Fault:

[    7.531332] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x03 received:
[    7.531890] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000800000003
[    7.532371] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
[    7.533189] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
[    7.533674] arm-smmu-v3 arm-smmu-v3.0.auto:  0x00000000000001e0
[    7.534136] arm-smmu-v3 arm-smmu-v3.0.auto: Event 0x3 received: F_STE_FETCH
[    7.534136]  client: 0000:00:01.0 sid: 0x8 ssid: 0x0
[    7.534136]  Fetch Address: 0x1e0

3. Permission Fault:

[    7.547455] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x13 received:
[    7.547997] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000800000013
[    7.548476] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000020000000000
[    7.548949] arm-smmu-v3 arm-smmu-v3.0.auto:  0x00000000fffff040
[    7.549418] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
[    7.550168] arm-smmu-v3 arm-smmu-v3.0.auto: Event 0x13 received: F_PERMISSION
[    7.550168]  client: 0000:00:01.0 sid: 0x8 ssid: 0x0
[    7.550168]  iova 0xfffff040 ipa 0x0
[    7.550168]  Unpriv | Data | Write | S1 | Input address caused fault
[    7.550168]  STAG: 0x0

4. Translation Fault:

[    7.586428] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x10 received:
[    7.587012] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000800000010
[    7.587504] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000020000000000
[    7.587986] arm-smmu-v3 arm-smmu-v3.0.auto:  0x00000000fffff040
[    7.588745] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
[    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: Event 0x10 received: F_TRANSLATION
[    7.589219]  client: 0000:00:01.0 sid: 0x8 ssid: 0x0
[    7.589219]  iova 0xfffff040 ipa 0x0
[    7.589219]  Unpriv | Data | Write | S1 | Input address caused fault
[    7.589219]  STAG: 0x0

5. Unknown / Implementation-defined Fault:

[    7.152599] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x0b received:
[    7.153064] arm-smmu-v3 arm-smmu-v3.0.auto:  0x000000080000000b
[    7.153755] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000010000000000
[    7.154239] arm-smmu-v3 arm-smmu-v3.0.auto:  0x00000000fffff040
[    7.154702] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
[    7.155169] arm-smmu-v3 arm-smmu-v3.0.auto: Event 0xb received: UNKNOWN
[    7.155169]  client: 0000:00:01.0 sid: 0x8 ssid: 0x0

v5
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


Pranjal Shrivastava (3):
  iommu/arm-smmu-v3: Introduce struct arm_smmu_event
  iommu/arm-smmu-v3: Log better event records
  iommu/arm-smmu-v3: Avoid redundant master lookup in events

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 173 ++++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  28 ++++
 2 files changed, 165 insertions(+), 36 deletions(-)

-- 
2.47.0.277.g8800431eea-goog


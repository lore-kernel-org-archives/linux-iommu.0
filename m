From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
Date: Mon, 1 Apr 2019 20:17:24 +0100
Message-ID: <8cc9ab56-3c50-9081-7276-a918ab23c924@arm.com>
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-4-robh@kernel.org>
 <40a521b3-a99c-2cd3-f3ac-cfec873fc934@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <40a521b3-a99c-2cd3-f3ac-cfec873fc934@baylibre.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>, Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Lyude Paul <lyude@redhat.com>, Eric Anholt <eric@anholt.net>, "Marty E . Plummer" <hanetzer@startmail.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
List-Id: iommu@lists.linux-foundation.org

On 01/04/2019 09:24, Neil Armstrong wrote:
> On 01/04/2019 09:47, Rob Herring wrote:
>> This adds the initial driver for panfrost which supports Arm Mali
>> Midgard and Bifrost family of GPUs. Currently, only the T860 and
>> T760 Midgard GPUs have been tested.
>>
>> v2:
>> - Add GPU reset on job hangs (Tomeu)
>> - Add RuntimePM and devfreq support (Tomeu)
>> - Fix T760 support (Tomeu)
>> - Add a TODO file (Rob, Tomeu)
>> - Support multiple in fences (Tomeu)
>> - Drop support for shared fences (Tomeu)
>> - Fill in MMU de-init (Rob)
>> - Move register definitions back to single header (Rob)
>> - Clean-up hardcoded job submit todos (Rob)
>> - Implement feature setup based on features/issues (Rob)
>> - Add remaining Midgard DT compatible strings (Rob)
>>
>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
>> Cc: Sean Paul <sean@poorly.run>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
>> Cc: Lyude Paul <lyude@redhat.com>
>> Cc: Eric Anholt <eric@anholt.net>
>> Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>> Neil, I've kept your reset support separate for now. Let me know if you
>> prefer me to squash it or keep it separate.
> 
> You can squash all my changes and add my sign-off.

FWIW, looking at Rob's branch there's a little bug in panfrost_reset_init():

+	if (IS_ERR(pfdev->rstc)) {
+		dev_err(pfdev->dev, "get reset failed %ld\n", PTR_ERR(pfdev->clock));

Looks like that "pfdev->clock" should be "pfdev->rstc".

Robin.

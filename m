From: Michael Zoran <mzoran@crowfest.net>
Subject: Re: [PATCH v3] drm/rockchip: update cursors asynchronously through
 atomic.
Date: Thu, 22 Nov 2018 22:58:10 -0600
Message-ID: <1d10a4323a49ca09bbb7dc865aaaf5b8c5e3b3d5.camel@crowfest.net>
References: <20181119190805.19139-1-helen.koike@collabora.com>
 <CAAFQd5DDZwhdMDbrHthQwm2bQ3+NoZNcemAktVTxkR3=LfnnTg@mail.gmail.com>
 <d3fb3b21-6c3d-6b01-727b-dbd66540ce92@collabora.com>
 <CAAFQd5Afa9ndmU0=q5Kjv-BY+0qpvOdq2+eOTO6OebX4-2NENA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAAFQd5Afa9ndmU0=q5Kjv-BY+0qpvOdq2+eOTO6OebX4-2NENA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomasz Figa <tfiga@chromium.org>, helen.koike@collabora.com, Eric Anholt <eric@anholt.net>
Cc: =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@google.com>, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Sean Paul <seanpaul@google.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, David Airlie <airlied@linux.ie>, "list@263.net:IOMMU
 DRIVERS <iommu@lists.linux-foundation.org>,	Joerg   Roedel
 <joro@8bytes.org>, " <joro@8bytes.org>, Sandy Huang <hjc@rock-chips.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>"list@263.net:IOMMU
 DRIVERS <iommu@lists.linux-foundation.org>,	Joerg   Roedel
 <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, kernel@collabora.com, "list@263.net:IOMMU DRIVERS
 <iommu@lists.linux-foundation.org>, Joerg   Roedel <joro@8bytes.org>,
 " <linux-arm-ker>
List-Id: iommu@lists.linux-foundation.org

On Fri, 2018-11-23 at 11:27 +0900, Tomasz Figa wrote:
> 
> The point here is not about setting and resetting the plane->fb
> pointer. It's about what happens inside
> drm_atomic_set_fb_for_plane().
> 
> It calls drm_framebuffer_get() for the new fb and
> drm_framebuffer_put() for the old fb. In result, if the fb changes,
> the old fb, which had its reference count incremented in the atomic
> commit that set it to the plane before, has its reference count
> decremented. Moreover, if the new reference count becomes 0,
> drm_framebuffer_put() will immediately free the buffer.
> 
> Freeing a buffer when the hardware is still scanning out of it isn't
> a
> good idea, is it?

No, it's not.  But the board I submitted the patch for doesn't have
anything like hot swapable ram.  The ram access is still going to work,
just it might display something it shouldn't. Say for example if that
frame buffer got reused by somethig else and filled with new data in
the very small window.

But yes, I agree the best solution would be to not release the buffer
until the next vblank.

Perhaps a good solution would be for the DRM api to have the concept of
a deferred release?  Meaning if the put() call just added the frame
buffer to a list that DRM core could walk during the vblank.  That
might be better then every single driver trying to work up a custom
solution.

> The vc4 driver seems to be able to program the hardware to switch the
> scanout to the new buffer immediately:
> 
> https://elixir.bootlin.com/linux/v4.20-rc3/source/drivers/gpu/drm/vc4/vc4_plane.c#L794
> 
> Although I wonder if there isn't still a tiny race there - the
> hardware may have just started refilling the FIFO from the old
> address. Still, if the FIFO is small, the FIFO refill operation may
> be
> much shorter than it takes for the kernel code to actually free the
> buffer. Eric and Michael, could you confirm?
> 

I don't have those boards anymore, and I don't have access to any
technical documentation on the GPU so I can't really add much here.  
Eric can probably provide the best information.

I submitted the patch because I was working on arm64 support for fun
and was becomming very annoyed by desktop lockups for long periods of
time on the desktop enviroment of my choice due to the driver being
flooded with curser animation updates.  I sent the patch to Eric who
was kind enough to review it and suggest some improvements.  

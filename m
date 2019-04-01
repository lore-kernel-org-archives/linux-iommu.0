From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH v2 2/3] drm: Add a drm_gem_objects_lookup helper
Date: Mon, 01 Apr 2019 14:48:16 +0100
Message-ID: <155412649586.24691.809508732198367112@skylake-alporthouse-com>
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-3-robh@kernel.org>
 <CAKMK7uE7-XV3cZxS8GT_EDa7yojOLPQi+LqkF85h_0z_JL6gYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAKMK7uE7-XV3cZxS8GT_EDa7yojOLPQi+LqkF85h_0z_JL6gYw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Sean Paul <sean@poorly.run>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
List-Id: iommu@lists.linux-foundation.org

Quoting Daniel Vetter (2019-04-01 14:06:48)
> On Mon, Apr 1, 2019 at 9:47 AM Rob Herring <robh@kernel.org> wrote:
> > +{
> > +       int i, ret = 0;
> > +       struct drm_gem_object *obj;
> > +
> > +       spin_lock(&filp->table_lock);
> > +
> > +       for (i = 0; i < count; i++) {
> > +               /* Check if we currently have a reference on the object */
> > +               obj = idr_find(&filp->object_idr, handle[i]);
> > +               if (!obj) {
> > +                       ret = -ENOENT;

Unwind previous drm_gem_object_get(), the caller has no idea how many
were processed before the error.
-Chris

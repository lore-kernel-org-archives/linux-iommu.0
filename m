From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/6] iommu/amd: Implement DOMAIN_ATTR_GEOMETRY attribute
Date: Mon, 30 Jan 2012 15:49:09 +0100
Message-ID: <20120130144909.GT19255@amd.com>
References: <1327603257-17028-1-git-send-email-joerg.roedel@amd.com>
	<1327603257-17028-3-git-send-email-joerg.roedel@amd.com>
	<CAK=WgbbZB0hGRr84JV4a7c0KvW7VbVzsnCx1PGg=wjoB0OSrYw@mail.gmail.com>
	<20120127102608.GK19255@amd.com>
	<CAK=WgbZQB+76FuJXK82x09CieDmF23zLQ8KbHbEtjnQsc_4axg@mail.gmail.com>
	<20120127130329.GM19255@amd.com>
	<CAK=WgbY+aBwTno4YxGLaxS7Y-R=CS1604+c5j-6EMQSfJeGvTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAK=WgbY+aBwTno4YxGLaxS7Y-R=CS1604+c5j-6EMQSfJeGvTA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sat, Jan 28, 2012 at 10:44:22PM +0200, Ohad Ben-Cohen wrote:
> On Fri, Jan 27, 2012 at 3:03 PM, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org> wrote:
> > Note that only the read-side is handled by the core. An IOMMU driver may
> > decide to implement a write-side for the geometry which would be not in
> > the core then. Having a dedicated function for the write-side does not
> > make sense because (for now) there is only one upcoming driver requiring
> > this.
> 
> I'd still go with a type-safe interface here, but maybe it's only me.

Well, the idea still stands to replace 'void *data' with something like
'union domain_attr *data'. This isn't as type-safe as dedicated
functions, but still better than void*.

> I'm not so sure how would drivers use these "hardware-specific api
> attr extensions" in general.

Depends on the attribute. For the geometry attribute drivers that
allocate a domain should read out the geometry and only use the range
returned for map/unmap (or fail initialization when the domain geometry
is unexpected).

> Is the intention that only hardware-specific drivers will use them ? I
> guess that generic drivers won't be able to use them, because their
> behavior will not be well-defined across all hardware implementations.

Hardware specific attributes are intended, but not limited to hardware
specific drivers. A generic driver that _may_ run on a given hardware
can use a hardware specific attribute too. If it doesn't run on this
hardware it will just get -EINVAL back.

Regards,

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

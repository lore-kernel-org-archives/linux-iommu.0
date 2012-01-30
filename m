From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/6] iommu/amd: Implement DOMAIN_ATTR_GEOMETRY attribute
Date: Mon, 30 Jan 2012 17:42:42 +0200
Message-ID: <CAK=WgbYhymxGi4VHKcYe1Lq6KHC3Lp5zCOYGdD334GjmB-mmTQ@mail.gmail.com>
References: <1327603257-17028-1-git-send-email-joerg.roedel@amd.com>
	<1327603257-17028-3-git-send-email-joerg.roedel@amd.com>
	<CAK=WgbbZB0hGRr84JV4a7c0KvW7VbVzsnCx1PGg=wjoB0OSrYw@mail.gmail.com>
	<20120127102608.GK19255@amd.com>
	<CAK=WgbZQB+76FuJXK82x09CieDmF23zLQ8KbHbEtjnQsc_4axg@mail.gmail.com>
	<20120127130329.GM19255@amd.com>
	<CAK=WgbY+aBwTno4YxGLaxS7Y-R=CS1604+c5j-6EMQSfJeGvTA@mail.gmail.com>
	<20120130144909.GT19255@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120130144909.GT19255-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 30, 2012 at 4:49 PM, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org> wrote:
> Hardware specific attributes are intended, but not limited to hardware
> specific drivers. A generic driver that _may_ run on a given hardware
> can use a hardware specific attribute too. If it doesn't run on this
> hardware it will just get -EINVAL back.

That sounds good.

But I'm still not sure what's the advantage of the attribute API on
top of regular, type-safe, dedicated API for every attribute: it
doesn't sound like there's a vast number of attributes, only a
handful, and dedicated API just sound (to me) much more readable and
less prone to error.

But, again, maybe it's only me :)

Thanks,
Ohad.

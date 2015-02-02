From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/5] iommu: Limit iommu_attach/detach_device to devices
	with their own group
Date: Mon, 2 Feb 2015 16:45:46 +0000
Message-ID: <20150202164545.GH31847@arm.com>
References: <1422317339-22620-1-git-send-email-joro@8bytes.org>
	<1422317339-22620-4-git-send-email-joro@8bytes.org>
	<20150128143523.GR1569@arm.com> <20150130122814.GC3702@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150130122814.GC3702-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 30, 2015 at 12:28:14PM +0000, Joerg Roedel wrote:
> On Wed, Jan 28, 2015 at 02:35:24PM +0000, Will Deacon wrote:
> > On Tue, Jan 27, 2015 at 12:08:57AM +0000, Joerg Roedel wrote:
> > > @@ -51,6 +51,7 @@ struct iommu_group {
> > >  	void (*iommu_data_release)(void *iommu_data);
> > >  	char *name;
> > >  	int id;
> > > +	unsigned dev_cnt;
> > 
> > Is this actually used on a fast path, or can we just inspect the list of
> > devices on the group instead?
> 
> Not really a fast path, but we have to hold the group mutex while
> traversing the list, which could hurt performance somewhere else. Are
> these 4 bytes a problem?

No problem, it just seemed a bit redundant to have two ways of describing
the same thing and having the pain of keeping them in sync with each other.

Will

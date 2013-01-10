From: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH v6 00/12] iommu/exynos: Fixes and Enhancements of System
	MMU driver with DT
Date: Thu, 10 Jan 2013 11:33:41 -0800
Message-ID: <02ae01cdef69$67d66200$37832600$@samsung.com>
References: <003301cde30b$c584c2d0$508e4870$%cho@samsung.com>
	<032401cde783$485ae1a0$d910a4e0$@samsung.com>
	<20130110171844.GA2650@8bytes.org>
	<027601cdef61$2df576a0$89e063e0$@samsung.com>
	<20130110191207.GI25591@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20130110191207.GI25591-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-language: en-us
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Joerg Roedel' <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: 'Linux Samsung SOC' <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Hyunwoong Kim' <khw0178.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Prathyush' <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Subash Patel' <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Linux Kernel' <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Linux IOMMU' <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, 'Cho KyongHo' <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Linux ARM Kernel' <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, 'Rahul Sharma' <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

'Joerg Roedel' wrote:
> 
> On Thu, Jan 10, 2013 at 10:34:48AM -0800, Kukjin Kim wrote:
> > Hmm, I think, just one [7/12] patch does matter so if you could create
topic
> > branch and apply [7/12] patch firstly before other drivers/ changes
would
> be
> > better to me. It's OK on both trees if I just _merge_ the first [7/12]
> > commit in the topic branch you provided for exynos-iommu. But you know,
> you
> > don't have to rebase it once I merge it in Samsung tree.
> >
> > How about?
> 
> Sounds good. Should I take the patch directly from this post? I would
> add your Acked-by then and make it the base for the arm/exynos branch.

Sure, keep going on with

Acked-by: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

> Once the branch is set-up, as usual it will not be rebased.

OK, good. Let me know the name of branch when you set-up it :-)

Thanks.

- Kukjin

From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v7 0/5] Add Intel IOMMU debugfs support
Date: Mon, 19 Mar 2018 09:37:14 -0700
Message-ID: <20180319093714.3afe698b@jacob-builder>
References: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
	<20180213140303.42mbzfxpypljy37l@8bytes.org>
	<20180213214002.GA27066@otc-nc-03>
	<20180213145332.35c73eda@jacob-builder>
	<20180215095337.fccoozdclfnbepi4@8bytes.org>
	<20180215083811.3ec86e49@jacob-builder>
	<20180315131854.s6xmltsvsysublcw@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180315131854.s6xmltsvsysublcw-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Ravi V Shankar <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Raj,
	Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 15 Mar 2018 14:18:54 +0100
Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:

> On Thu, Feb 15, 2018 at 08:38:11AM -0800, Jacob Pan wrote:
> > Just wondering if your concern is on the implementation or the
> > debugfs idea in general. Perhaps have some common IOMMU debugfs?  
> 
> My concern mainly is that we add interfaces which reveal
> potentially security relevant information
I don;t think security is any worse than existing kernel page table in
debugfs. i.e. /sys/kernel/debug/page_tables
This is a debug feature.
> to user-space and that tools
> come up using it so that this also becomes kABI and we can't easily
> change it anymore and this whole stuff turns into a maintence
> nightmare.
> 
Agreed, perhaps we can address that by only dumping user readable data
which avoid having a parser tool that relies on stable kABI?

> So that is definitly not something I'd like to see enabled in the
> distros, and its better to avoid it at all and search for better ways
> to debug upcoming issues.
> 
We can make it "def_bool n" so only used by advanced customers who can
recompile kernel.
> BPF tracers and tracing in general comes to mind here...
> 
my concern is that tracing is suitable for dynamic debugging, but these
context info are mostly static. Perhaps I am missing some tracing
features.

Thanks,

Jacob
> 
> 	Joerg
> 

[Jacob Pan]

From: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] vfio/pci: Some buggy virtual functions incorrectly
	report 1 for intx.
Date: Thu, 9 Aug 2018 16:03:11 -0700
Message-ID: <20180809230311.GA79703@otc-nc-03>
References: <1533843426-79170-1-git-send-email-ashok.raj@intel.com>
	<20180809134417.50de7fe7@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180809134417.50de7fe7-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Gage Eads <gage.eads-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Aug 09, 2018 at 01:44:17PM -0600, Alex Williamson wrote:
> On Thu,  9 Aug 2018 12:37:06 -0700
> Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> 
> > PCI_INTERRUPT_PIN should always read  0 for SRIOV Virtual Functions.
> > 
> > Some SRIOV devices have some bugs in RTL and VF's end up reading 1
> > instead of 0 for the PIN.
> 
> Hi Ashok,
> 
> One question, can we identify which VFs are known to have this issue so
> that users (and downstreams) can know how to prioritize this patch?
> Thanks,

Hi Alex,

The hardware isn't public yet, so can't talk about it :-(. Once this patch gets 
merged, will let the OSV engagement folks drive it for inclusions. We 
could mark this for stable, but i would rather wait until we know the 
timeline when they are expecting it to be in. It shouldn't break anything
since we are just enforcing the spec.

Cheers,
Ashok

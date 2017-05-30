From: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] PCI: Save properties required to handle FLR for
	replay purposes.
Date: Tue, 30 May 2017 09:31:34 -0700
Message-ID: <20170530163132.GA167511@otc-nc-03>
References: <1494441543-8216-1-git-send-email-ashok.raj@intel.com>
	<aa916e13-063f-3b25-34a5-b1a24200e021@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <aa916e13-063f-3b25-34a5-b1a24200e021-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, May 11, 2017 at 11:50:24AM +0100, Jean-Philippe Brucker wrote:
> Hi,
> 
> On 10/05/17 19:39, Ashok Raj wrote:
> > From: CQ Tang <cq.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > 
> > Requires: https://patchwork.kernel.org/patch/9593891
> 
> Since your series is likely to go in much earlier than my SVM mess, maybe
> you could carry that PCI patch along with it? Or I could resend it on its
> own if you prefer.

I have send the 2 patches to the list, so we can get them in before the long
SVM series gets in. 



> 
> I'm planning to resend the SVM series in a few weeks but it still won't
> make it into mainline since it hasn't run on hardware.
> 
> Thanks,
> Jean-Philippe
> 
Cheers,
Ashok

From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [BUGREPORT] Intel X58 Boards don't boot after "iommu/vt-d: Make
	root entry visible for hardware right after allocation"
Date: Wed, 15 Jun 2016 18:11:49 +0200
Message-ID: <20160615161149.GJ13971@8bytes.org>
References: <CAH-=PyRpjuKf0XJNyzkVLpggaaYq163AfA84SZ5=DQH2Ys5Lkw@mail.gmail.com>
	<CAH-=PyR-6sY1vuzQSfJyh35Q+WqZKD70Ev7vDns+02h8j=m18Q@mail.gmail.com>
	<20160425110151.GE17926@8bytes.org>
	<CAH-=PyTGF76sq7LvQH0-28DoK1dXGUOdnCF6z9shF_CWosWYwQ@mail.gmail.com>
	<CAH-=PyTaR-xH7D4eOnFkB-7gojdZW08yHEPP2Gw2-0GjWTA4dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAH-=PyTaR-xH7D4eOnFkB-7gojdZW08yHEPP2Gw2-0GjWTA4dw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dheeraj CVR <cvr.dheeraj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Apr 29, 2016 at 04:41:23PM +0400, Dheeraj CVR wrote:
> Hi=A0Joerg,
> =

> Did you find time to have a look at the dmesg that I have sent to you in =
the
> earlier email? Please let me know if you need any more debugging info to
> diagnose this issue.

Yes, I had a look at the dmesg and went through the code again. I have
no clue yet why that commit causes the issue on your machine. Between
the two places in the code where the set_root_entry calls are/were,
there are no other things going on with the iommu hardware, so it
shouldn't matter when setting the root entry happens earlier.

Can you try to track down (with some debug code) exactly where it is
hanging? That might bring some more light into the issue.



	Joerg

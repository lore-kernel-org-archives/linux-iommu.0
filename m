From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH v9 02/13] x86: always set IF before oopsing from page
 fault
Date: Thu, 4 Apr 2019 18:23:50 +0200
Message-ID: <20190404162349.rvkaozmtozamdoar@linutronix.de>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
 <e6c57f675e5b53d4de266412aa526b7660c47918.1554248002.git.khalid.aziz@oracle.com>
 <CALCETrXvwuwkVSJ+S5s7wTBkNNj3fRVxpx9BvsXWrT=3ZdRnCw@mail.gmail.com>
 <20190404013956.GA3365@cisco>
 <CALCETrVp37Xo3EMHkeedP1zxUMf9og=mceBa8c55e1F4G1DRSQ@mail.gmail.com>
 <20190404154727.GA14030@cisco>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190404154727.GA14030@cisco>
Sender: linux-kernel-owner@vger.kernel.org
To: Tycho Andersen <tycho@tycho.ws>
Cc: Andy Lutomirski <luto@kernel.org>, Khalid Aziz <khalid.aziz@oracle.com>, iommu@lists.linux-foundation.org, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Khalid Aziz <khalid@gonehiking.org>
List-Id: iommu@lists.linux-foundation.org

- stepping on del button while browsing though CCs.
On 2019-04-04 09:47:27 [-0600], Tycho Andersen wrote:
> > Hmm.  do_exit() isn't really meant to be "try your best to leave the
> > system somewhat usable without returning" -- it's a function that,
> > other than in OOPSes, is called from a well-defined state.  So I think
> > rewind_stack_do_exit() is probably a better spot.  But we need to
> > rewind the stack and *then* turn on IRQs, since we otherwise risk
> > exploding quite badly.
> 
> Ok, sounds good. I guess we can include something like this patch in
> the next series.

The tracing infrastructure probably doesn't know that the interrupts are
back on. Also if you were holding a spin lock then your preempt count
isn't 0 which means that might_sleep() will trigger a splat (in your
backtrace it was zero).

> Thanks,
> 
> Tycho
Sebastian
